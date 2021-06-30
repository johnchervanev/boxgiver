class CreateSponsoredPayments < ActiveRecord::Migration[5.2]
  def change
    create_table :sponsored_payments do |t|
      t.integer :listing_id
      t.string :payment_result
      t.string :charge_id
      t.string :email
      t.string :phone
      t.string :balance_transaction
      t.string :customer_id
      t.float :amount
      t.boolean :payment_status

      t.timestamps
    end
  end
end
