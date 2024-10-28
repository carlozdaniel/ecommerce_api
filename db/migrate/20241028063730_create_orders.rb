class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :total_price, precision: 10, scale: 2, default: 0.0
      t.string :status, default: 'pending'
      t.string :shipping_address
      t.string :payment_status, default: 'unpaid'

      t.timestamps
    end
  end
end
