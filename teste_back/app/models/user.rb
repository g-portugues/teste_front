class User < ApplicationRecord
  include Publicable, Modifiable

  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}
  validates :name, presence: true
  validates :password,
            length: {minimum: 6},
            if: -> {new_record? || !password.nil?}

  upcase :nome
  downcase :email
end
