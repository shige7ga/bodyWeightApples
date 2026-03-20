class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :height,
    numericality: true,
    format: {
      with: /\A\d{1,3}(\.\d)?\z/,
      message: 'は整数3桁まで、小数1桁までで入力してください（例：165.5）'
    },
    allow_nil: true

    # password validation(create時、入力必須)
    validates :password, confirmation: true, length: { minimum: 8, maximum: 32 }, presence: true

  has_secure_password
  has_many :weight_records, dependent: :destroy

  # 定数：りんごの重さ300g/個 あとでデータベース化する予定
  APPLE_WEIGHT = 300

  def ideal_apple_weight
    if !self.height.nil?
      weight = self.height * self.height * 22 / 10 # 体重をg換算
      return (weight / APPLE_WEIGHT).round
    end
    return ' -- '
  end

  def ideal_weight
    if !self.height.nil?
      return (self.height * self.height * 22 / 10000).round(1)
    end
    return ' -- '
  end

end
