Stripe.api_key =  ApplicationHelper.get_stripe_secret(1)
unless defined? STRIPE_JS_HOST
  STRIPE_JS_HOST = 'https://js.stripe.com'
end

