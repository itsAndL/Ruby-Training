require 'rails_helper'

RSpec.describe "posts/edit", type: :view do
  current_user = User.first_or_create!(email: "me@test.com", password: 'password', password_confirmation: 'password')

  let(:post) {
    Post.create!(
      title: "MyString",
      body: "MyText",
      user: current_user,
      views: 1
    )
  }

  before(:each) do
    assign(:post, post)
  end

  it "renders the edit post form" do
    render

    assert_select "form[action=?][method=?]", post_path(post), "post" do

      assert_select "input[name=?]", "post[title]"

      assert_select "textarea[name=?]", "post[body]"
    end
  end
end
