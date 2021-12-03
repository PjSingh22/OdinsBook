class FriendsController < ApplicationController
  def index
    @friends = current_user.friends
  end

  def destroy
    current_user.remove_friend(@friend)
  end

  private

  def set_friend
    @friend = curent_user.friends.find(params[:id])
  end
end
