# == Schema Information
#
# Table name: listing_lovers
#
#  id         :bigint           not null, primary key
#  person_id  :string(255)
#  listing_id :integer
#

require 'rails_helper'

RSpec.describe ListingLover, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
