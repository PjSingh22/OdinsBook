require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'should return an error' do
      user = User.new
      user.valid?
      expect(user.errors.messages[:email]).to include("can't be blank")
    end

    it 'should create a user' do
      user = User.create(email: 'dave@gmail.com', password: 'password', username: 'daveboy', name: 'dave')
      match_user = User.find_by(email: 'dave@gmail.com')
      expect(match_user).to eq(user)
    end
  end
end
