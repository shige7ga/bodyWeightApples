class WeightRecord < ApplicationRecord
  validates :weight,
    presence: true,
    numericality: true,
    format: {
      with: /\A\d{1,3}(\.\d)?\z/,
      message: 'は整数3桁まで、小数1桁までで入力してください（例：62.7）'
    }

  validates :comment, length: { maximum: 2000 }

  belongs_to :user

  def apple_weight
    gram_weight = self.weight * 1000 #g換算
    return (gram_weight / APPLE_WEIGHT).round
  end

end
