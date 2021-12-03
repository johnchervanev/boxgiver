class CreateNewsletterSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :newsletter_subscriptions do |t|
      t.string :email
      t.string :token

      t.timestamps
    end
  end
end
