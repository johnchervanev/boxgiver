class CreateListingReports < ActiveRecord::Migration[5.2]
  def change
    create_table :listing_reports do |t|
      t.string :person_id
      t.integer :listing_id
      t.string :reason
      t.timestamps
    end
  end
end
