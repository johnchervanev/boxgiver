class AddLastCommunityUpdatesAtToNewsletterSubscription < ActiveRecord::Migration[5.2]
  def change
    add_column :newsletter_subscriptions, :last_community_updates_at, :timestamp
  end
end
