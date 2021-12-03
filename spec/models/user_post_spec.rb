require 'rails_helper'

RSpec.describe UserPost, type: :model do
  describe "validations" do
    it "should return an error if message is blank" do
      post = UserPost.new
      expect(post.valid?).to eq(false)
    end
  end
end
