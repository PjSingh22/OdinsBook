class FriendRequestsController < ApplicationController
  # before_action :set_friend_request, only: [:index, :create]

  def index
    @incoming = FriendRequest.where(friend: current_user)
    @outgoing = current_user.friend_requests
  end

  def create
    friend = User.find(params[:friend_id])
    @friend_request = current_user.friend_requests.create(friend: friend)

    if @friend_request.save
      flash[:notice] = "Friend request sent"
      redirect_to users_path(friend)
      # render :show, status: :created, location: @friend_request
    else
      render json: @friend_request.errors, status: :unprocessable_entity
    end
  end

  def accept
    # redirect_to friends_url(params[:id], method: :create)
    # redirect_to Friendship.create(user: current_user, friend_id: params[:id])
    # destroy
    friend = User.find(params[:id])
    current_user.friends << friend
    redirect_to '/pending_requests'
    flash[:notice] = "Friend request accepted"
    # destroy
  end

  def reject
    destroy
  end

  def destroy
    # fix this issue
    @friend_request = FriendRequest.where(user: params[:id], friend: current_user).first
    if @friend_request.present?
      @friend_request.destroy
    end
    head :no_content
  end

  private

  def set_friend_request
    @friend_request = FriendRequest.find(params[:id])
  end

  def friend_request_params
    params.require(:friend_request).permit(:friend_id, :user_id)
  end
end
