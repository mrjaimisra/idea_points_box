require 'rails_helper'

describe 'the users is an administrator' do

  it 'show all users to a logged in admin' do
    admin = User.create(username: "admin", password: "admin", role: 1)
    ApplicationController.any_instance.stub(:current_user).and_return(admin)

    visit admin_users_path

    expect(page).to have_content("All Users")
  end

  it 'does not show all users to user with default role' do
    admin = User.create(username: "admin", password: "admin", role: 0)
    ApplicationController.any_instance.stub(:current_user).and_return(admin)

    visit admin_users_path

    expect(page).to_not have_content("All Users")
    expect(page).to have_content("The page you were looking for doesn't exist.")
  end
end