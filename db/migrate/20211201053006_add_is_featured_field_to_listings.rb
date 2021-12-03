class AddIsFeaturedFieldToListings < ActiveRecord::Migration[5.2]
  def change
    add_column :listings, :is_featured, :boolean, default: false
  end
end
