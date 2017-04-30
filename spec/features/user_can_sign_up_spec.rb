require 'rails_helper'

describe 'when a user visits root it can sign up' do
  context 'a user can sign up' do
    it 'can visit the sign up page' do
      visit root_path
      expect(page).to have_content("Log in")

      click_on 'Sign up'
      expect(page).to have_content("Sign up")
    end
    it 'a unauthenticated user can sign up' do
      visit root_path
      expect(page).to have_content("Log in")
      click_on 'Sign up'
      expect(page).to have_content("Sign up")

      within("#new_user") do
        fill_in "user_email", with: "newuser@example.com"
        fill_in "user_password", with: "testpassword"
        fill_in "user_password_confirmation", with: "testpassword"
      end
      click_button "Sign up"

      expect(User.first.email).to eq("newuser@example.com")
      expect(page).to have_content("Log in")
    end
  end
end
