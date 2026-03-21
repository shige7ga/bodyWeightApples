class WeightRecordDecorator < Draper::Decorator
  delegate_all

  def apple_weight
    gram_weight = object.weight * 1000 # g換算
    (gram_weight / WeightRecord::APPLE_WEIGHT).round
  end

  # 現在体重と比較する体重の差を出力
  def gap_apple_weight(compared_weight)
    # 現在のリンゴ数 - 目的のリンゴ数 → -だと達成
    apple_weight - compared_weight
  end

  def compare_ideal_current_apple_weight
    gap = gap_apple_weight(object.user.decorate.ideal_apple_weight)
    if gap <= 0
      "達成！！！"
    else
      "達成まであと" + gap.to_s + "個分、減らす！！！"
    end
  end

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end
end
