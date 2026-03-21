class UsersController < ApplicationController
  skip_before_action :require_login, only: [:index, :show, :new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :ensure_user_authorized, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, success: t(".success")
    else
      flash.now[:danger] = t(".danger")
      render 'new', status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), success: t(".success")
    else
      flash.now[:danger] = t(".danger")
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy!
    redirect_to users_path, status: :see_other, success: 'ユーザを削除しました'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def ensure_user_authorized
    ensure_correct_user(@user)
  end

  def user_params
    params.require(:user).permit(:name, :email, :height, :password, :password_confirmation)
  end
end
