require 'rails_helper'

RSpec.describe "user_posts/index", type: :view do
  before(:each) do
    assign(:user_posts, [
      UserPost.create!(
        message: "Message"
      ),
      UserPost.create!(
        message: "Message"
      )
    ])
  end

  it "renders a list of user_posts" do
    render
    assert_select "tr>td", text: "Message".to_s, count: 2
  end
end
