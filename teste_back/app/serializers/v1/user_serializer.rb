module V1
  class UserSerializer < ActiveModel::Serializer
    attribute(:id) {object.public_id}
    attributes(
      :email,
      :name
    )
  end
end
