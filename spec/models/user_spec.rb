require "rails_helper"

describe User do

  include TestFactories

  before do
    @user = authenticated_user
    @post = associated_post
  end

  describe "#favourited(post)" do
    it "returns nil if a user has not favourited a post" do
      expect( @user.favorited(@post) ).to eq(nil)
    end

    it "returns the relevant post if it has been favourited" do
      favorite = @user.favorites.where(post_id: @post).create
      expect( @user.favorited(@post) ).to eq(favorite)
    end
  end
end
