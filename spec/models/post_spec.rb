require "rails_helper"

describe Post do

  describe "vote_methods" do

    before do
      @post = associated_post
      3.times { @post.votes.create(value: 1) }
      2.times { @post.votes.create(value: -1) }
    end

    describe "#up_votes" do
      it "should count the number of votes with a value of -1" do
        expect( @post.up_votes ).to eq(3)
      end
    end

    describe "#down_votes" do
      it "should count the number of votes with a value of 1" do
        expect( @post.down_votes ).to eq(2)
      end
    end

    describe "#points" do
      it "should count the sum of all up and down votes " do
        expect( @post.points ).to eq(1)
      end
    end

    describe "#create_vote" do
      it "should create and up vote when a vote is saved" do
        post = associated_post
        expect( post.up_votes ).to eq(0)
        post.create_vote
        expect( post.up_votes ).to eq(1)
      end
    end

  end

end

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
