# rubocop:disable Style/MixinUsage
include ApplicationHelper
include ListingsHelper
include TruncateHtmlHelper
# rubocop:enable Style/MixinUsage

class NewsLetterMailer < ActionMailer::Base
  helper :markdown

  include MailUtils

  require "truncate_html"

  def self.deliver_community_updates
    community = Community.first
    NewsletterSubscription.find_each do |subscription|
      listings_to_send = community.get_new_listings_to_update_email_for_subscription(subscription) if community.automatic_newsletters
      next if listings_to_send.blank?

      p "$$$$$$$$$$"
      p subscription
      p listings_to_send

      begin
        ApplicationHelper.store_community_service_name_to_thread_from_community(community)

        MailCarrier.deliver_now(
          NewsLetterMailer.community_updates(
            recipient: subscription,
            community: community,
            listings: listings_to_send,
          ))
      rescue StandardError => e

        puts "Error sending mail to #{subscription.email} community updates: #{e.message}"
        ApplicationHelper.send_error_notification("Error sending mail to #{subscription.email} community updates: #{e.message}", e.class)
      end

      subscription.update_attribute(:last_community_updates_at, Time.now)
    end
  end

  def community_updates(recipient:, community:, listings:)
    @community = community
    @current_community = community
    @recipient = recipient
    @listings = listings

    with_locale('en', community.locales.map(&:to_sym), community.id) do

      @number_of_days = time_difference_in_days(@recipient.last_community_updates_at)
      @time_since_last_update = t("timestamps.days_since", :count => @number_of_days)
      @url_params = build_default_locale_url_params(@community, "weeklymail")

      @show_listing_shape_label = community.shapes.count > 1
      @show_branding_info = !PlanService::API::Api.plans.get_current(community_id: community.id).data[:features][:whitelabel]
      @title_link_text = t("emails.community_updates.title_link_text",
                           :community_name => @community.full_name('en'))
      subject = t("emails.community_updates.update_mail_title", :title_link => @title_link_text)
      # @url = "http://198.211.105.116"
      @url = "http://lvh.me:3001/en"

      delivery_method = APP_CONFIG.mail_delivery_method.to_sym unless Rails.env.test?

      mail(:to => @recipient.email,
           :from => community_specific_sender(community),
           :subject => subject,
           :delivery_method => delivery_method) do |format|
        # format.html { render v2_template(community.id, 'community_updates'), layout: v2_layout(community.id, 'email_blank_layout') }
        format.html { render 'community_updates', layout: 'email_blank_layout' }
      end
    end
  end

  private

  def time_difference_in_days(from_time, to_time = Time.now)
    return 1 if from_time.nil?

    from_time = from_time.to_time if from_time.respond_to?(:to_time)
    to_time = to_time.to_time if to_time.respond_to?(:to_time)
    distance_in_minutes = (((to_time - from_time).abs/60)/1440.0).round
  end

  def premailer_mail(opts, &block)
    premailer(mail(opts, &block))
  end
end

