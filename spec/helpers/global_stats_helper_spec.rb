require 'rails_helper'

describe 'get global stats data' do
  before(:each) do
    @key        = ENV['STATS_API_KEY']
    @start_date = "2017-01-01"
    @end_date   = "2017-01-03"
  end
  it 'should get global stats data form the stats api' do
    VCR.use_cassette "global_stats" do
      data = GlobalStats.get_global_data(@start_date, @end_date, @key)

      expect(data).to be_an_instance_of(Hash)
      expect(data.first[:date]).to eq(@start_date)
    end
  end
end
