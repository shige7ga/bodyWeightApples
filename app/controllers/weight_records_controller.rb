class WeightRecordsController < ApplicationController
  skip_before_action :require_login, only: [:index, :show]
  before_action :set_weight_record, only: [:show, :edit, :update, :destroy]
  before_action :ensure_user_authorized, only: [:edit, :update, :destroy]

  def index
    @weight_records = WeightRecord.includes(:user).order(created_at: :desc)
  end

  def new
    @weight_record = WeightRecord.new
  end

  def create
    @weight_record = current_user.weight_records.build(weight_record_params)
    if @weight_record.save
      redirect_to weight_records_path, notice: t(".notice")
    else
      flash.now[:danger] = t(".alert")
      render 'new', status: :unprocessable_entity
    end
  end

  def show

  end

  def edit

  end

  def update
    if @weight_record.update(weight_record_params)
      redirect_to weight_record_path(@weight_record), notice: t(".notice")
    else
      flash.now[:danger] = t(".alert")
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @weight_record.destroy!
    redirect_to user_path(current_user), status: :see_other, notice: t(".notice")
  end


  private

  def set_weight_record
    @weight_record = WeightRecord.find(params[:id])
  end

  def ensure_user_authorized
    ensure_correct_user(@weight_record.user)
  end

  def weight_record_params
    params.require(:weight_record).permit(:weight, :comment)
  end

end
