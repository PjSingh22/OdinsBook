class CommentsController < ApplicationController
  before_action :set_post

  def create
    @comment = @user_post.comments.create(comment_params)
    @comment.user_id = current_user.id
    @comment.save

    if @comment.save
      redirect_to user_post_path(@user_post)
    else
      render 'new'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_post
    @user_post = UserPost.find(params[:user_post_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:user_post_id, :user_id, :message)
  end
end
