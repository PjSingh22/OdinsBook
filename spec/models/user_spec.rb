require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'should return an error' do
      user = User.new
      user.valid?
      expect(user.errors.messages[:email]).to include("can't be blank")
    end
  end
end
