class CreatePublishers < ActiveRecord::Migration[6.0]
  def change
    create_table :publishers do |t|
      t.string :name, null: false
      t.string :public_id
      t.timestamps
      
      t.index :public_id, unique: true
    end
  end
end
