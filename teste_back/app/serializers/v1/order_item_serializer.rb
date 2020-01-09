module V1
  class OrderItemSerializer < ActiveModel::Serializer
    belongs_to :book
    belongs_to :order

    attribute(:id) {object.public_id}
    attributes(
      :amount,
      :price,
      :descount,
      :total
    )
  end
end
