class LikesController < ApplicationController
  before_action :find_post

  def create
    if already_liked?
      flash[:notice] = "You can't like more than once"
    else
    @user_post.likes.create(user_id: current_user.id)
    end
    redirect_to root_path
  end

  private
    def find_post
      @user_post = UserPost.find(params[:user_post_id])
    end

    def already_liked?
      Like.where(user_id: current_user.id, post_id:
      params[:post_id]).exists?
    end
end
