require "rails_helper"

describe Comment do

  include TestFactories

  describe "after_create" do

    before do
      @post = associated_post
      @favourited_user = authenticated_user(favourited: true)
      @commenting_user = authenticated_user
      @comment = Comment.new(body: "My new comment", post: @post, user: @commenting_user)
    end

    it "sends an e-mail to users who have favourited the post" do
      favorite = @favourited_user.favorites.create(post: @post) 

      allow( FavoriteMailer ).to receive(:new_comment).with(@user, @post, @comment).and_return( double(deliver_now: true) )

      expect( FavoriteMailer ).to receive( :new_comment )
      @comment.save
    end

    it "should not send an e-mail to those who have not favourited the post" do
      expect( FavoriteMailer ).not_to receive( :new_comment )
      @comment.save
    end
  end
end
