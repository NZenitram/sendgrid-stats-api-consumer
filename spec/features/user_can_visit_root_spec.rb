require 'rails_helper'

describe 'a user can visit root' do
  it 'visits /' do

    visit '/'

    expect(page).to have_content("Welcome")
  end
end
