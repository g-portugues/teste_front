module V1
  class PublisherSerializer < ActiveModel::Serializer
    has_many :books

    attribute(:id) {object.public_id}
    attributes(
      :name
    )
  end
end
