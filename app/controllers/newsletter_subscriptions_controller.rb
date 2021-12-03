class NewsletterSubscriptionsController < ApplicationController
  layout false

  def subscribe
    regular_user = Email.find_by_address(params[:email])
    unless regular_user.present?
      subscriber = NewsletterSubscription.find_or_initialize_by(email: params[:email])
      subscriber.token = Digest::SHA1.hexdigest([Time.now, rand].join)
      subscriber.save!
    end
    respond_to do |format|
      format.js
    end
  end

  def unsubscribe
    subscriber = NewsletterSubscription.find_by_token(params[:token])
    if subscriber.present?
      subscriber.destroy
    end
  end
end
