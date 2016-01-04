module TestFactories
  def associated_post(options={})
    post_options = {
      user: authenticated_user,
      topic: Topic.create(name: 'Topic Name'),
      title: 'Post title',
      body: 'Post title must be very long'
    }.merge(options)
    Post.create(post_options)
  end

  def authenticated_user(options={})
    user_options = {
      email: "email#{rand}@test.com",
      password: 'password'
    }.merge(options)
    user = User.new(user_options)
    user.skip_confirmation!
    user.save
    user
  end
end
