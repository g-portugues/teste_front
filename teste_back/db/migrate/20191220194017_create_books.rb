class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.references :author, null: false, foreign_key: true
      t.float :price, null: false
      t.string :public_id
      t.timestamps
      
      t.index :public_id, unique: true
    end
  end
end
