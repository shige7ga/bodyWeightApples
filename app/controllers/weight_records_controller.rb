class WeightRecordsController < ApplicationController
  def index
    @weight_records = WeightRecord.includes(:user).order(created_at: :desc)
  end

  def new
    @weight_record = WeightRecord.new
  end

  def create
    @weight_record = current_user.weight_records.build(weight_record_params)
    if @weight_record.save
      redirect_to weight_records_path, notice: '体重記録の登録を完了しました'
    else
      flash.now[:danger] = '体重記録の登録に失敗しました'
      render 'new', status: :unprocessable_entity
    end
  end


  private

  def weight_record_params
    params.require(:weight_record).permit(:weight, :comment)
  end

end
