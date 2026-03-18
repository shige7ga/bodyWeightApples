class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    @ideal_weight = calc_ideal_weight(@user.height)
    @apple_weight_count = convert_height_to_apple_weight(@user.height)
  end

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

  # 定数：りんごの重さ300g/個 あとでデータベース化する予定
  APPLE_WEIGHT = 300

  def convert_height_to_apple_weight(height)
    if !height.nil?
      weight = height * height * 22 / 10 # 体重をg換算
      return (weight / APPLE_WEIGHT).round
    end
    return ' -- '
  end

  def calc_ideal_weight(height)
    if !height.nil?
      return (height * height * 22 / 10000).round(1)
    end
    return ' -- '
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :height)
  end
end
