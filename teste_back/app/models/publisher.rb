class Publisher < ApplicationRecord
  include Publicable, Modifiable

  has_and_belongs_to_many :books

  validates :name, presence: true, uniqueness: true

  upcase :name
end
