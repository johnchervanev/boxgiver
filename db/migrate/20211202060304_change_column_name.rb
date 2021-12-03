class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :blogs, :description, :content
  end
end
