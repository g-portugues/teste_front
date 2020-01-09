class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :customer, foreign_key: {to_table: 'users'}
      t.string :public_id
      t.timestamps
      
      t.index :public_id, unique: true
    end
  end
end
