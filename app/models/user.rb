class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :height,
    numericality: true,
    format: {
      with: /\A\d{1,3}(\.\d)?\z/,
      message: "は整数3桁まで、小数1桁までで入力してください（例：165.5）"
    },
    allow_nil: true

  # password validation(create時、入力必須)
  validates :password, confirmation: true, length: { minimum: 8, maximum: 32 }, presence: true

  mount_uploader :avatar, AvatarUploader
  has_secure_password
  has_many :weight_records, dependent: :destroy
  has_many :comment, dependent: :destroy
end
