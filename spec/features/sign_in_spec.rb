require "rails_helper"

describe "sign in process" do

  include TestFactories

  describe "successful" do
    it "redirects to the topics the index" do
      user = authenticated_user
      visit root_path

      click_link 'sign-in'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password

      within 'form' do
        click_button 'Log in'
      end

      expect( current_path ).to eq(topics_path)
    end


  end
end
