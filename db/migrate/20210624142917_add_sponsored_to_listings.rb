class AddSponsoredToListings < ActiveRecord::Migration[5.2]
  def change
    add_column :listings, :sponsored, :boolean, default: false
    add_column :listings, :sponsored_at, :timestamp

  end
end
