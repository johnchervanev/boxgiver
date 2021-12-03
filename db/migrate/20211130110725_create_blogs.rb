class CreateBlogs < ActiveRecord::Migration[5.2]
  def change
    create_table :blogs do |t|
      t.integer :community_id
      t.string :author
      t.string :title
      t.text :description
      t.string :image
      t.string :slug
      t.boolean :published

      t.timestamps
    end
  end
end
