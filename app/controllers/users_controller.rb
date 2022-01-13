class UsersController < ApplicationController

  def index
    @users = User.all
    @user = current_user
  end

  def show
    @user_posts = UserPost.where(user_id: params[:id]).all
    @user = User.find(params[:id])
  end

  def all_other_users
    @everyone_else = User.all.where.not(id: current_user.id)
  end

  def search
    @query = params[:query].downcase
    @searched_users = User.where("LOWER(name) LIKE ?", "%#{@query}%").order(:name)
  end
end
