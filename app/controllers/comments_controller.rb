class CommentsController < ApplicationController
  before_action :set_comment, only: [ :edit, :update, :destroy ]
  before_action :ensure_comment_authorized, only: [ :edit, :update, :destroy ]

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.save
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

  def destroy; end

  private

  def set_comment
    # ログインユーザーに紐づくコメントから対象コメントを探す
    @comment = current_user.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body).merge(weight_record_id: params[:weight_record_id])
  end

  def update_comment_params
    params.require(:comment).permit(:body)
  end

  def ensure_comment_authorized
    ensure_correct_user(@comment.user)
  end
end
