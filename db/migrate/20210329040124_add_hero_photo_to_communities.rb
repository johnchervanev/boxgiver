class AddHeroPhotoToCommunities < ActiveRecord::Migration[5.2]
  def change
    add_column :communities, :hero_photo, :string
    add_column :communities, :hero_photo_file_name, :string
    add_column :communities, :hero_photo_content_type, :string
    add_column :communities, :hero_photo_processing, :boolean
  end
end
