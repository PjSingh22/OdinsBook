class FriendsController < ApplicationController
  def index
    @friends = current_user.friends
  end

  def create
    @friend = current_user.friends.build(params[:friend_id])
    if @friend.save
      # figure out why it is not redirecting
      flash[:notice] = "Friend was successfully added."
      redirect_to '/pending_requests'
    else
      flash[:error] = "Unable to add friend."
      render :json => @friend.errors, :status => :unprocessable_entity
    end
  end

  def destroy
    current_user.remove_friend(@friend)
  end

  private

  def set_friend
    @friend = curent_user.friends.find(params[:id])
  end

  def friend_params
    params.require(:friend).permit(:friend_id)
  end
end
