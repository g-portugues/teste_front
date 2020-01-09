module V1
  class BookSerializer < ActiveModel::Serializer
    belongs_to :author
    belongs_to :publishers

    attribute(:id) {object.public_id}
    attributes(
      :title,
      :price
    )
  end
end
