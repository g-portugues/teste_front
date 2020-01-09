class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email, index: true
      t.string :name, null: false
      t.string :password_digest
      t.string :public_id
      t.timestamps
      
      t.index :public_id, unique: true
    end
  end
end
