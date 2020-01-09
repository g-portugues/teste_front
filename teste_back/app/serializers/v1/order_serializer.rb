module V1
  class OrderSerializer < ActiveModel::Serializer
    has_many :order_items
    belongs_to :custumer, class_name: 'User'

    attribute(:id) {object.public_id}
  end
end
