require 'rails_helper'

describe 'GET api/v1/:provider' do
  it 'returns json of the providers events' do

    get "/api/v1/providers/gmail"


  end
end
