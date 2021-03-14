class AddTwitterAnnouncementEnabledToCommunity < ActiveRecord::Migration[5.2]
  def change
    add_column :communities, :twitter_announcement_enabled, :boolean, default: true
  end
end
