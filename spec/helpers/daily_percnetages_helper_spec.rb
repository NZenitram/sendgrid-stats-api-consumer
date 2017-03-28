require 'rails_helper'
require 'csv'

describe 'get_providers' do
  it "returns percentages from a CSV" do

    csv = CSV.read("./spec/assets/test_assets/response_csv", :headers => true)
    inbox = csv['provider']
    email_providers = inbox.uniq

    expect(email_providers).to be_an_instance_of(Array)
    expect(email_providers[0]).to eq("AOL")
  end
end
