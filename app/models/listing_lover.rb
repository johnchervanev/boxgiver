# == Schema Information
#
# Table name: listing_lovers
#
#  id         :bigint           not null, primary key
#  person_id  :string(255)
#  listing_id :integer
#

class ListingLover < ApplicationRecord
  belongs_to :listing
  belongs_to :person
end
