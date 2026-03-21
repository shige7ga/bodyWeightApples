class UserDecorator < Draper::Decorator
  delegate_all

  def ideal_apple_weight
    if !object.height.nil?
      weight = object.height * object.height * 22 / 10 # 体重をg換算
      return (weight / User::APPLE_WEIGHT).round
    end
    " -- "
  end

  def ideal_weight
    if !object.height.nil?
      return (object.height * object.height * 22 / 10000).round(1)
    end
    " -- "
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
