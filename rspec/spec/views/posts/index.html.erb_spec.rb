require 'rails_helper'

RSpec.describe "posts/index", type: :view do
  current_user = User.first_or_create!(email: "me@test.com", password: 'password', password_confirmation: 'password')
  
  before(:each) do
    assign(:posts, [
      Post.create!(
        title: "Title",
        body: "MyText",
        user: current_user,
        views: 24
      ),
      Post.create!(
        title: "Title",
        body: "MyText",
        user: current_user,
        views: 12
      )
    ])
  end

  it "renders a list of posts" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Title".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(current_user.id.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(24.to_s), count: 1
    assert_select cell_selector, text: Regexp.new(12.to_s), count: 1
  end
end
