require 'rails_helper'

describe 'when a user visits root it can log in' do
  before(:each) do
    user = FactoryGirl.create(:user)
    user.confirmed_at = Time.now
    user.save
    @user = user
  end
  context 'it can login' do
    it 'can visit log in page' do
      visit root_path

      expect(page).to have_content("Log in")
    end
  end
  it "a user can log in" do
    visit root_path
    within('#new_user') do
      fill_in "user_email", with: @user.email
      fill_in "user_password", with: @user.password
    end

    click_button "Log in"

    expect(page).to have_content("Signed in successfully.")
  end
  it 'a user can log out after they have logged in' do
    visit root_path
    within('#new_user') do
      fill_in "user_email", with: @user.email
      fill_in "user_password", with: @user.password
    end

    click_button "Log in"
    expect(page).to have_content("Signed in successfully.")
    click_on 'Log out'
    expect(page).to have_content("Log in")
  end
  it 'a user can visit their profile page after they log in' do
    visit root_path
    within('#new_user') do
      fill_in "user_email", with: @user.email
      fill_in "user_password", with: @user.password
    end

    click_button "Log in"
    expect(page).to have_content("Signed in successfully.")
    click_on 'Profile'
    expect(page).to have_content("Edit User")
  end
  it 'a user can change their password from the profile page' do
    visit root_path
    within('#new_user') do
      fill_in "user_email", with: @user.email
      fill_in "user_password", with: @user.password
    end

    click_button "Log in"
    expect(page).to have_content("Signed in successfully.")
    click_on 'Profile'
    expect(page).to have_content("Edit User")

    within('#edit_user') do
      fill_in "user_password", with: "newpassword"
      fill_in "user_password_confirmation", with: "newpassword"
      fill_in "user_current_password", with: @user.password
    end
    click_button "Update"

    expect(page).to have_content("Your account has been updated successfully.")
  end
end
