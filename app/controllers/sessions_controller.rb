class SessionsController < ApplicationController
  skip_before_action :require_login, only: [ :new, :create ]

  def new; end

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_path(user), success: t(".notice")
    else
      flash.now[:danger] = t(".danger")
      render "new", status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to root_path, status: :see_other, success: t(".notice")
  end
end
