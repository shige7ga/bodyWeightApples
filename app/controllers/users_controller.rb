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
      redirect_to users_path, notice: 'ユーザ登録が完了しました'
    else
      flash.now[:danger] = 'ユーザ登録に失敗しました'
      render 'new', status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'ユーザ情報を編集しました'
    else
      flash.now[:danger] = '編集に失敗しました'
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy!
    redirect_to users_path, status: :see_other, notice: 'ユーザを削除しました'
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
