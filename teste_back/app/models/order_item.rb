class OrderItem < ApplicationRecord
  include Publicable, Modifiable

  belongs_to :book
  belongs_to :order

  validates :order,
            :book,
            :amount,
            :price,
            :total,
            presence: true

  upcase :name
end
