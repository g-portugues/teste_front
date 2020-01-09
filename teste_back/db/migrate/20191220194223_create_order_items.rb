class CreateOrderItems < ActiveRecord::Migration[6.0]
  def change
    create_table :order_items do |t|
      t.references :order, null:false, foreign_key: true
      t.references :book, null:false, foreign_key: true
      t.integer :amount, null:false
      t.float :price, null:false
      t.float :descount, defalt: 0
      t.float :total, null:false
      t.string :public_id
      t.timestamps

      t.index :public_id, unique: true
    end
  end
end
