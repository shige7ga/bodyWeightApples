class CommentsController < ApplicationController
  before_action :set_comment, only: [ :edit, :update, :destroy ]

  def create
    comment = current_user.comments.build(comment_params)
    if comment.save
      redirect_to weight_record_path(comment.weight_record), success: t('.success')
    else
      redirect_to weight_record_path(comment.weight_record), danger: t('.danger')
    end
  end

  def edit
    @weight_record = WeightRecord.find(@comment.weight_record_id)
  end

  def update
    if @comment.update(update_comment_params)
      redirect_to weight_record_path(@comment.weight_record), success: t('.success')
    else
      flash.now[:danger] = t(".danger")
      render "edit", status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy!
    weight_record = @comment.weight_record_id
    redirect_to weight_record_path(weight_record), status: :see_other, success: t('.success')
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body).merge(weight_record_id: params[:weight_record_id])
  end

  def update_comment_params
    params.require(:comment).permit(:body)
  end
end
