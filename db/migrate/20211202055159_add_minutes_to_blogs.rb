class AddMinutesToBlogs < ActiveRecord::Migration[5.2]
  def change
    add_column :blogs, :minutes, :decimal
  end
end
