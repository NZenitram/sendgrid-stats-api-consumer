require 'rails_helper'

describe 'when a user visits root' do
  context 'it can login' do
    it 'can visit log in page' do
      visit root_path

      expect(page).to have_content("Log in")
    end
  end
  it "a user can log in" do
    user = FactoryGirl.create(:user)
    user.confirmed_at = Time.now
    user.save

    visit root_path
    within('#new_user') do
      fill_in "user_email", with: user.email
      fill_in "user_password", with: user.password
    end

    click_button "Log in"

    expect(page).to have_content("Signed in successfully.")
  end
end
