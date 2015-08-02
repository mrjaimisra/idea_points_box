require 'rails_helper'

describe 'a user visits the login page' do
  it 'allows a user to create an account' do
    visit root_path

    click_link "Create Account"
    fill_in "Username", with: "Jai"
    fill_in "Password", with: "123"
    click_button "Create Account"

    user = User.find_by(username: "Jai")

    expect(current_path).to eq(user_path(user))

    # within("flash_greeting") do
      expect(page).to have_content("Welcome, Jai.")
    # end

    expect(page).to have_content("Jai's ideas:")
  end
end