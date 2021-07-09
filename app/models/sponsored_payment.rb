# == Schema Information
#
# Table name: sponsored_payments
#
#  id                  :bigint           not null, primary key
#  listing_id          :integer
#  payment_result      :string(255)
#  charge_id           :string(255)
#  email               :string(255)
#  phone               :string(255)
#  balance_transaction :string(255)
#  customer_id         :string(255)
#  amount              :float(24)
#  payment_status      :boolean
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class SponsoredPayment < ApplicationRecord
  belongs_to :listing
  def self.add_pay(stripeToken,email,phone,listing_id)
    customer = Stripe::Customer.create(
      email: email,
      source: stripeToken
    )
    stripe_charge = Stripe::Charge.create(
      customer: customer.id,
      amount: 50,
      description: 'w2a customer',
      currency: 'usd'
    )
    if stripe_charge.present?
      payment =  SponsoredPayment.create(
        charge_id: stripe_charge.id,
        email: email,
        phone: phone,
        customer_id: customer.id,
        amount: stripe_charge.amount,
        payment_status: true,
        listing_id: listing_id
      )
      if payment.present?
        list = Listing.find(listing_id)
        list.update(sponsored: true, sponsored_at: Time.now)
        Delayed::Job.enqueue(RemoveSponsoredJob.new(listing_id), run_at: DateTime.now + 7.days, priority: 7)
      end
      payment
    else
      nil
    end


  end
end
