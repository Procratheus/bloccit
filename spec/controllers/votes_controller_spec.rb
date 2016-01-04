require 'rails_helper'

RSpec.describe VotesController, type: :controller do

  include TestFactories
  include Devise::TestHelpers

  describe "#up_vote" do
    it "should add a up-vote to a post" do
      request.env["HTTP_REFERER"] = '/'
      @post = associated_post
      @user = authenticated_user
      sign_in @user

      expect{ post(:up_vote, post_id: @post.id ) }.to change{ @post.up_votes }.by 1
    end
  end

end
