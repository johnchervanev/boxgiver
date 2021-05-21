class UpdatePersonIdFieldToListingLovers < ActiveRecord::Migration[5.2]
  def change
    change_column :listing_lovers, :person_id, :string
  end
end
