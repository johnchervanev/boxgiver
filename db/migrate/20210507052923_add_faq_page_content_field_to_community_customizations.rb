class AddFaqPageContentFieldToCommunityCustomizations < ActiveRecord::Migration[5.2]
  def change
    add_column :community_customizations, :faq_page_content, :mediumtext
  end
end
