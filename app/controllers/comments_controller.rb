class CommentsController < ApplicationController
  before_action :set_post
  before_action :set_comment, only: [:edit, :update, :destroy]

  def create
    @comment = @user_post.comments.create(comment_params)
    @comment.user_id = current_user.id
    @comment.save

    if @comment.save
      flash[:notice] = "Comment was successfully posted!"
      redirect_to user_post_path(@user_post)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to user_post_path(@user_post)
    else 
      render 'edit'
    end
  end

  def destroy
    @comment = @user_post.comments.find(params[:id])
    @comment.destroy
    flash[:notice] = "Comment was successfully deleted!"
    redirect_to user_post_path(@user_post)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_post
    @user_post = UserPost.find(params[:user_post_id])
  end

  def set_comment
    @comment = @user_post.comments.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:user_post_id, :user_id, :message)
  end
end
