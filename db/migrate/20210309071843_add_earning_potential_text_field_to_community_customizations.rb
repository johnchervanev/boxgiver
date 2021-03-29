class AddEarningPotentialTextFieldToCommunityCustomizations < ActiveRecord::Migration[5.2]
  def change
    add_column :community_customizations, :earning_potential_text, :text
    add_attachment :communities, :earning_potential_image
  end
end
