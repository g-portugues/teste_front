class Author < ApplicationRecord
  include Publicable, Modifiable

  has_many :books

  validates :name, presence: true, uniqueness: true

  upcase :name
end
