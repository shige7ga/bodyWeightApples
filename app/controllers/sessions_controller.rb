class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new; end

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_path(user), notice: 'ログインしました'
    else
      flash.now[:alert] = 'ログインに失敗しました'
      render 'new', status: :upprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to root_path, status: :see_other, notice: 'ログアウトしました'
  end
end
