require "rails_helper"

describe Comment do

  include TestFactories

  describe "after_create" do

    before do
      @post = associated_post()
      @favorited_user = authenticated_user(email_favorites: true)
      @commenting_user = authenticated_user
      @comment = Comment.new(body: "My new comment", post: @post, user: @commenting_user)
    end

    context "with user's permission" do
      it "sends an e-mail to users who have favourited the post" do
        @favorited_user.favorites.where(post: @post).create

        allow( FavoriteMailer ).to receive(:new_comment).with(@favorited_user, @post, @comment).and_return( double(deliver_now: true) )

        expect( FavoriteMailer ).to receive( :new_comment )
        @comment.save
      end

      it "should not send an e-mail to those who have not favourited the post" do
        expect( FavoriteMailer ).not_to receive( :new_comment )
        @comment.save
      end
    end

    context "without permission" do

      before do
        @commenting_user.update_attribute(:email_favorites, false)
      end

      it "does not send an email to users who have favorited" do
        @commenting_user.favorites.where(post: @post).create

        expect(FavoriteMailer).not_to receive(:new_comment)

        @comment.save
      end
    end

  end
end
