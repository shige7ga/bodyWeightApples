class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 }, format: { with: URI::MailTo::EMAIL_REGEXP }

  has_secure_password
end
