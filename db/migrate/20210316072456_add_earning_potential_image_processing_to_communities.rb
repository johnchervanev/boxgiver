class AddEarningPotentialImageProcessingToCommunities < ActiveRecord::Migration[5.2]
  def change
    add_column :communities, :earning_potential_image_processing, :boolean
  end
end
