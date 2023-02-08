require 'rails_helper'
include PostsHelper

# Specs in this file have access to a helper object that includes
# the PostsHelper. For example:
#
# describe PostsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe PostsHelper, type: :helper do
  it 'assign a user to a post' do
    # AAA
    # Arange, Act, Assert

    # Arranging our data => assigning variables
    creator = User.first_or_create!(email: "me@test.com", password: 'password', password_confirmation: 'password')

    @post = Post.new(title: "MyString", body: 'MyText', views: 1)

    # Act=> we're acting with our arrange variables
    returned_post = assign_post_creator(@post, creator)

    # Assert => Assert that our expected outcome matches our actual outcome.
    expect(returned_post.user).to be(creator)
  end
end
