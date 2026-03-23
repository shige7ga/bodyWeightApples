class CommentsController < ApplicationController
  def create
    comment = current_user.comments.build(comment_params)
    if comment.save
      redirect_to weight_record_path(comment.weight_record), success: t('.success')
    else
      redirect_to weight_record_path(comment.weight_record), danger: t('.danger')
    end
  end

  def edit

  end

  def destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(weight_record_id: params[:weight_record_id])
  end
end
