class Book < ApplicationRecord
  include Publicable, Modifiable

  belongs_to :author
  has_and_belongs_to_many :publishers
  has_many :order_items

  validates :title,
            :price,
            presence: true

end
