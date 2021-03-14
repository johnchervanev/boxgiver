
class ListingAnnouncementJob < Struct.new(:listing_id, :platform)
  # :listing_id
  # :platform

  def perform
    listing = Listing.find(listing_id)
    "Announcement#{platform.capitalize}".constantize.new(listing)
  end
end
