require 'rails_helper'

describe 'a user can visit root' do
  it 'visits /' do

    visit '/'

    expect(page).to have_content("Welcome To SendGrid Stats")
  end
end

describe 'a user can visit providers' do
  it 'visits /providers' do

    visit '/providers'

    expect(page).to have_content("Inbox Statistics By Provider")
  end
end

describe 'when a user vists /providers it sees a list of providers' do
  it 'vists /providers and sees a list of providers' do
    @providers = ["Gamil", "Yahoo", "Hotmail"]

    visit '/providers'
    
    expect(page).to have_content("Gmail")
  end
end
