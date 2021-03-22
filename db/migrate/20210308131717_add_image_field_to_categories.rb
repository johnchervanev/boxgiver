class AddImageFieldToCategories < ActiveRecord::Migration[5.2]
  def change
    add_attachment :categories, :image
  end
end
