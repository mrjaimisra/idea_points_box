require 'rails_helper'

describe 'a users visits the login page' do
  it 'allows a users to create an account' do
    visit root_path

    click_link "Create Account"

    expect(current_path).to eq(new_user_path)

    fill_in "Username", with: "Jai"
    fill_in "Password", with: "123"
    click_button "Create Account"

    user = User.find_by(username: "Jai")

    expect(current_path).to eq(user_path(user))

    # within("flash_greeting") do
      expect(page).to have_content("Welcome, Jai")
    # end

    expect(page).to have_content("Jai's ideas:")
  end

  it 'validates a new username is unique' do
    visit root_path

    user = User.create(username: "Rowdy", password: "Ronda")

    click_link "Create Account"

    fill_in "Username", with: user.username
    fill_in "Password", with: "Ronda"
    click_button "Create Account"

    # within("flash_errors") do
    expect(page).to have_content("Username '#{user.username}' is already in use")
    # end

    expect(current_path).to eq(new_user_path)
  end

  it 'allows a users to login' do
    visit root_path
    user = User.create(username: "Rowdy", password: "Ronda")

    fill_in "Username", with: user.username
    fill_in "Password", with: "Ronda"
    click_button "Login"

    expect(current_path).to eq(user_path(user))

    expect(page).to have_content("Rowdy's ideas:")
  end

  it 'errors when a users attempts to login with an unknown username' do
    visit root_path

    fill_in "Username", with: "Rowby"
    fill_in "Password", with: "Ronda"
    click_button "Login"

    expect(current_path).to eq(login_path)
    expect(page).to have_content("That username is not in our database")

  end

  it 'errors when a users enters an incorrect password' do
    visit root_path
    user = User.create(username: "Rowdy", password: "Ronda")

    fill_in "Username", with: user.username
    fill_in "Password", with: "Rona"
    click_button "Login"

    expect(current_path).to eq(login_path)
    expect(page).to have_content("Your password was entered incorrectly")
  end
end