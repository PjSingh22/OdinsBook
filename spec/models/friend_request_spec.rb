require 'rails_helper'

RSpec.describe FriendRequest, type: :model do
  describe 'request creation' do
    user = User.create(email: 'dave@gmail.com', password: 'password', username: 'daveboy', name: 'dave')
    friend = User.create(email: 'dave@gmail.com', password: 'password', username: 'daveboy', name: 'dave')
    friend_request = FriendRequest.new(user: user.id, friend: friend.id)

    it 'creates a new friend request' do
      expect(friend_request.save).to eq(true)
    end 
  end
end
