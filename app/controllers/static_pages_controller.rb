class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: [ :index ]
  before_action :redirect_mypage_if_logged_in, only: [ :index ]

  def index; end

  private

  def redirect_mypage_if_logged_in
    redirect_to user_path(current_user) if logged_in?
  end
end
