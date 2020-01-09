json.extract! orders_item, :id, :book_id, :amount, :price, :descount, :total, :created_at, :updated_at
json.url orders_item_url(orders_item, format: :json)
