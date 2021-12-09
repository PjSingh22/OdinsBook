class FriendRequestsController < ApplicationController
  # before_action :set_friend_request, only: [:index, :create]

  def index
    @incoming = FriendRequest.where(friend: current_user)
    @outgoing = current_user.friend_requests
  end

  def create
    friend = User.find(params[:friend_id])
    # @friend_request = FriendRequest.create(user: user, friend: friend)
    @friend_request = current_user.friend_requests.create(friend: friend)

    if @friend_request.save
      flash[:notice] = "Friend request sent"
      redirect_to root_path
      # render :show, status: :created, location: @friend_request
    else
      render json: @friend_request.errors, status: :unprocessable_entity
    end
  end

  def accept
    Friendship.create(friend_id: params[:id])
    destroy
  end

  def update
    @friend_request.accept
    head :no_content
  end

  def destroy
    # fix this issue
    @friend_request.destroy
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
