require "rails_helper"

describe "Proifile Page" do

  include TestFactories

  before do
    @user = authenticated_user
    @post = associated_post(user: @user)
    @comment = Comment.new(body: "This is a new comment", post: @post, user: @user)
    allow(@comment).to receive(:send_favorite_emails)
    @comment.save
    @signed_in_user = login_as(@user, scope: :user)
  end

  describe "not signed in" do
    it "should allow the visitor to view the profile" do
      visit user_path(@user)

      expect(current_path).to eq(user_path(@user))
      expect( page ).to have_content( @user.name )
      expect( page ).to have_content( @post.title )
      expect( page ).to have_content( @comment.body )
    end

    it "should allow a user to visit someone elses profile" do
      visit user_path(@signed_in_user)

      expect(current_path).to eq(user_path(@user))
      expect( page ).to have_content( @user.name )
      expect( page ).to have_content( @post.title )
      expect( page ).to have_content( @comment.body )
    end

  end

end
