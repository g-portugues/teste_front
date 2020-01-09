class Order < ApplicationRecord
  include Publicable, Modifiable

  has_many :order_items
  belongs_to :custumer, class_name: 'User'

  validates :customer, presence: true

  upcase :name
end
