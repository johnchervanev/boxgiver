class AddLandingPageMoreFieldsToCommunity < ActiveRecord::Migration[5.2]
  def change
    add_column :communities, :list_title, :string, default: 'All Types Of Boards'
    add_column :communities, :hw_list, :text
    add_column :communities, :hw_sell, :text
    add_column :communities, :hw_delivery, :text
    add_column :communities, :hw_paid, :text
  end
end
