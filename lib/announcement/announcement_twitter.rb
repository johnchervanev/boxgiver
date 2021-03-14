require 'twitter'

class AnnouncementTwitter
  include Rails.application.routes.url_helpers
  default_url_options[:host] = APP_CONFIG.domain

  def initialize(listing)
    client.update(
      I18n.t(
        'listings.announcement.twitter_html',
        listing_title: listing.title,
        listing_url: listing_url(id: listing.to_param, locale: I18n.locale),
        full_name: listing.author.display_name || listing.author.full_name
      )
    )
  end

  private

  def client
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = APP_CONFIG.twitter_consumer_key
      config.consumer_secret     = APP_CONFIG.twitter_consumer_secret
      config.access_token        = APP_CONFIG.twitter_access_token
      config.access_token_secret = APP_CONFIG.twitter_access_token_secret
    end
  end
end
