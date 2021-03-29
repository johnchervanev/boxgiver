class CreateListingLovers < ActiveRecord::Migration[5.2]
  def change
    create_table :listing_lovers do |t|
      t.integer :person_id
      t.integer :listing_id
    end
  end
end
