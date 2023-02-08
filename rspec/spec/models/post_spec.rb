require 'rails_helper'

RSpec.describe Post, type: :model do
  current_user = User.first_or_create!(email: "me@test.com", password: 'password', password_confirmation: 'password')

  it 'has a title' do
    post = Post.new(
      title: '',
      body: 'This is body',
      user: current_user,
      views: 0
    )
    expect(post).to_not be_valid

    post.title = 'has a title'
    expect(post).to be_valid
  end

  it 'has a body' do 
    post = Post.new(
      title: 'This is a title',
      body: '',
      user: current_user,
      views: 0
    )
    expect(post).to_not be_valid

    post.body = 'has a bdy'
    expect(post).to be_valid
  end

  it 'has a title at least 2 characters long' do
    post = Post.new(
      title: 'd',
      body: 'This is body',
      user: current_user,
      views: 0
    )
    expect(post).to_not be_valid

    post.title = 'ha'
    expect(post).to be_valid
    
  end

  it 'has a body between 5 and 100 charcters' do
    post = Post.new(
      title: 'This is a title',
      body: 'hifg',
      user: current_user,
      views: 0
    )
    expect(post).to_not be_valid

    post.body = 'has a body'
    expect(post).to be_valid

    hundred_char_string = 'dQTutSVGVv1M4VBDf7vVEmHhftUDyvjB1JNDxzeiXdFHNfInm0cVFYNRh7sJ3JsoRXmM5FgFV8uSlJqmBuksNUPs5lMRrFsFrhFF'

    post.body = hundred_char_string
    expect(post).to be_valid

    post.body = hundred_char_string + '1'
    expect(post).to_not be_valid
  end

  it 'has numericale views' do
    post = Post.new(
      title: 'This is a title',
      body: 'a valid body',
      user: current_user,
      views: 0
    )
    expect(post.views).to be_a(Integer)
  end
end
