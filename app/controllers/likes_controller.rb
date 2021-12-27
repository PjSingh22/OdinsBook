class LikesController < ApplicationController
  before_action :find_post
  before_action :find_like, only: [:destroy]

  def create
    if already_liked?
      flash[:notice] = "You can't like more than once"
    else
    @user_post.likes.create(user_id: current_user.id)
    end
    # fix this to reload the current page it is on whether it is the root or not
    redirect_to root_path
  end

  def destroy
    if !(already_liked?)
      flash[:notice] = "Cannot unlike"
    else
      @like = @user_post.likes.find(params[:id])
      @like.destroy
    end
    # redirect_to root_path
    redirect_to root_path
    # redirect_back(fallback_location: root_path)
  end

  private
    def find_post
      @user_post = UserPost.find(params[:user_post_id])
    end

    def find_like
      @like = @user_post.likes.find(params[:id])
   end

    def already_liked?
      Like.where(user_id: current_user.id, user_post_id:
      params[:user_post_id]).exists?
    end
end
