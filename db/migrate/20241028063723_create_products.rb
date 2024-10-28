class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.decimal :price
      t.integer :stock, default: 0
      t.boolean :in_stock, default: true, null: false

      t.timestamps
    end
  end
end
