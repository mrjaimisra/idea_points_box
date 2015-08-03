require 'rails_helper'

describe 'a users visits the show page and clicks logout' do

    it 'allows a users to logout' do
      visit root_path

      user = User.create(username: "Rowdy", password: "Ronda")

      fill_in "Username", with: user.username
      fill_in "Password", with: "Ronda"
      click_button "Login"

      click_link "Logout"
      # within("h2") do
        expect(page).to have_content("Sign In")
      # end

    end
end