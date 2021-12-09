class FriendRequestsController < ApplicationController
  before_action :set_friend_request, only: [:index, :new, :create]

  def index
    @incoming = FriendRequest.where(friend: current_user)
    @outgoing = current_user.friend_requests
  end

  def create
    @friend = User.find(params[:friend_id])
    @friend_request = current_user.friend_requests.new(friend: friend)

    if @friend_request.save
      render :show, status: :created, location: @friend_request
    else
      render json: @friend_request.errors, status: :unprocessable_entity
    end
  end

  def new
    @friend_request = FriendRequest.new
  end

  def accept
    User.friends << friend
    destroy
  end

  def update
    current_user.friends << friend
    destroy
    head :no_content
  end

  def destroy
    @friend_request.destroy
    head :no_content
  end

  private

  def set_friend_request
    @friend_request = FriendRequest.find(params[:id])
  end

  def friend_request_params
    params.require(:friend_request).permit(:friend_id)
  end
end
