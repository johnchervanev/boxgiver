# == Schema Information
#
# Table name: listing_reports
#
#  id         :bigint           not null, primary key
#  person_id  :string(255)
#  listing_id :integer
#  reason     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe ListingReport, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
