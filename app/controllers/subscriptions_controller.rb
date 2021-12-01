class SubscriptionsController < ApplicationController

  # layout :choose_layout

  def subscribe
    @subscription = Subscription.new(email: params[:email])
    data = { }
    if @subscription.save
      data[:notice] = 'Thanks for your subscription'
    else
      if @subscription.errors.full_messages.first == "Email has already been taken"
        data[:notice] = "You have already subscribed"
      else
        data[:notice] = @subscription.errors.full_messages.to_sentence
      end
    end
    render json: data
  end

  private

  def choose_layout
    if @current_community.private
      'private'
    else
      'application'
    end
  end

end
