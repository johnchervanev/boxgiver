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

class ListingReport < ApplicationRecord
  belongs_to :listing
  belongs_to :person
end
