class FriendRequestsController < ApplicationController
  before_action :set_friend_request, only: [:index, :new, :create]

  def index
    @incoming = FriendRequest.where(friend_id: current_user.id)
    @outgoing = current_user.friend_requests
  end

  def create
    friend = User.find(params[:friend_id])
    @friend_request = current_user.friend_requests.new(friend: friend.id)

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
    current_user.friends << friend
    destroy
  end

  def update
    @friend_request.accept
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
