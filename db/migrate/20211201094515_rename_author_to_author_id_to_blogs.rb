class RenameAuthorToAuthorIdToBlogs < ActiveRecord::Migration[5.2]
  def change
    rename_column :blogs, :author, :author_id
  end
end
