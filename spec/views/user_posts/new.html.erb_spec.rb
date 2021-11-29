require 'rails_helper'

RSpec.describe "user_posts/new", type: :view do
  before(:each) do
    assign(:user_post, UserPost.new(
      message: "MyString"
    ))
  end

  it "renders new user_post form" do
    render

    assert_select "form[action=?][method=?]", user_posts_path, "post" do

      assert_select "input[name=?]", "user_post[message]"
    end
  end
end
