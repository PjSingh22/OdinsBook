class UsersController < ApplicationController

  def show
    @user_posts = UserPost.where(user_id: params[:id]).all
    @user = User.find(params[:id])
  end
end
