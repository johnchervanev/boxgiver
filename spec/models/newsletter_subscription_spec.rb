# == Schema Information
#
# Table name: newsletter_subscriptions
#
#  id                        :bigint           not null, primary key
#  email                     :string(255)
#  token                     :string(255)
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  last_community_updates_at :datetime
#

require 'rails_helper'

RSpec.describe NewsletterSubscription, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
