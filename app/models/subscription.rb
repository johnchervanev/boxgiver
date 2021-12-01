# == Schema Information
#
# Table name: subscriptions
#
#  id         :bigint           not null, primary key
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Subscription < ApplicationRecord
  validates :email, uniqueness: true, format: /\w+@\w+\.{1}[a-zA-Z]{2,}/
  after_validation :is_registered?

  private

  def is_registered?
    email = Email.find_by(address: self.email)
    self.errors.add(:base, "You have already registered") if email.present?
  end
end
