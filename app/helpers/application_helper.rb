module ApplicationHelper
  def page_title(title = "")
    base_title = "リンゴで体重管理"
    title.present? ? "#{title} | #{base_title}" : base_title
  end
end
