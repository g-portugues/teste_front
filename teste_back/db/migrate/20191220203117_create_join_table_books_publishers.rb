class CreateJoinTableBooksPublishers < ActiveRecord::Migration[6.0]
  def change
    create_join_table :books, :publishers do |t|
      t.index :book_id
      t.index :publisher_id
    end
  end
end
