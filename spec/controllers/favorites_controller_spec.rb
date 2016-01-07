require "rails_helper"

describe FavouritesController do

  include TestFactories
  include Devise:TestHelpers

  before do
    @post = associated_post
    @user = authenticated_user
    sign_in @user
  end

  describe "#create" do
    it "should create a favourite for the current_user and the associated post" do
      expect( @user.favorites.find_by(post: @post)).to be_nil

      post :create, { post: @post }

      expect( @user.favorites.find_by(post: @post)).to be_nil
    end
  end

  describe "#destroy" do
    it "should remove a favourite for the current_user and its associated post" do
      favorite = @user.favorites.where(post: @post).create
      expect( @user.favorites.find_by(post: @post) ).to_not be_nil

      delete :destroy, { post: @post, id: favorite.id}

      expect( @user.favorites.find_by(post: @post) ).to be_nil
    end
  end

end
