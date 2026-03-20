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

  def gap_apple_weight(compared_weight)
    # 現在のリンゴ数 - 目的のリンゴ数 → -だと達成
    self.apple_weight - compared_weight
  end

  def compare_ideal_current_apple_weight
    gap = gap_apple_weight(self.user.ideal_apple_weight)
    if gap <= 0
      return '達成！！！'
    else
      return '達成まであと' + gap.to_s + '個分！！！'
    end
  end

end
