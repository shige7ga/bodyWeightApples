class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # データが存在しないエラー発生時の処理
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  helper_method :logged_in?, :current_user, :current_user?
  before_action :require_login

  def current_user?(user)
    current_user == user
  end

  def logged_in?
    !!current_user
  end

  def logout
    session[:user_id] = nil
    @current_user = nil
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def ensure_correct_user(user)
    redirect_to root_path, alert: '権限がありません' unless current_user?(user)
  end

  private

  def require_login
    redirect_to login_path unless logged_in?
  end

  def not_found
    redirect_to root_path, alert: '権限がありません'
  end
end
