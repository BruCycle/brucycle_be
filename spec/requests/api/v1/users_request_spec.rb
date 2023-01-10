require 'rails_helper'

RSpec.describe 'Users API' do
  before(:each) do 
    @json = File.read('spec/fixtures/gas_price.json')
        
    stub_request(:post, "https://www.gasbuddy.com/gaspricemap/county")
      .with(query: hash_including({}))
      .to_return(status: 200, body: @json)
  end
  
  describe '/api/v1/user' do
    it 'returns the user and following info' do
      user = create(:user)
      create_list(:activity, 5, user_id: user.id)
      headers = {'HTTP_STRAVA_UID' => "#{user.strava_uid}", 'HTTP_STRAVA_TOKEN' => "#{ENV['strava_token']}"}
      get '/api/v1/user', headers: headers

      athlete = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(athlete).to be_a Hash

      attrs = athlete[:data][:attributes]
      expect(attrs).to be_a Hash
      expect(attrs).to have_key(:brubank)
      expect(attrs[:brubank]).to be_a(Float)
      expect(attrs).to have_key(:tot_gas_money_saved)
      expect(attrs[:tot_gas_money_saved]).to be_a(Float)
      expect(attrs).to have_key(:tot_calories_burned)
      expect(attrs[:tot_calories_burned]).to be_a(Float)
      expect(attrs).to have_key(:tot_miles_biked)
      expect(attrs[:tot_miles_biked]).to be_a(Float)
    end

    it 'returns the user and following info even if user is not saved in db yet' do
      VCR.insert_cassette 'strava_facade_athlete'
      headers = {'HTTP_STRAVA_UID' => "123", 'HTTP_STRAVA_TOKEN' => "#{ENV['strava_token']}"}
      get '/api/v1/user', headers: headers

      athlete = JSON.parse(response.body, symbolize_names: true)
      expect(response).to be_successful
      expect(athlete).to be_a Hash
      VCR.eject_cassette
    end
    
    it 'returns a 400 status if only one header is included' do
      headers = {'HTTP_STRAVA_UID' => "123"}
      get '/api/v1/user', headers: headers

      expect(response.status).to eq(400)
      expect(response.body.include?('MISSING HEADERS')).to eq true
    end

    it 'deletes a beer from brubank and adds a beer to beers drunk' do
      user = create(:user, brubank: 10, beers_drunk: 2)
      beer_params = {drank: 'beer'}
      headers = {'HTTP_STRAVA_UID' => "#{user.strava_uid}"}
      patch "/api/v1/user", headers: headers, params: beer_params

      expect(response).to be_successful
      expect(response.status).to eq(200)

      user = JSON.parse(response.body, symbolize_names: true)
      expect(user[:data][:attributes][:brubank]).to eq(9)
      expect(user[:data][:attributes][:beers_drunk]).to eq(3)
    end

    it 'returns a 400 status if params are missing' do
      headers = {'HTTP_STRAVA_UID' => "123"}
      patch '/api/v1/user', headers: headers

      expect(response.status).to eq(400)
      expect(response.body.include?('MISSING PARAMS')).to eq true
    end

    it 'returns a 400 status if headers are missing when deleting a brü' do
      beer_params = {drank: 'beer'}
      patch '/api/v1/user', params: beer_params

      expect(response.status).to eq(400)
      expect(response.body.include?('MISSING HEADERS')).to eq true
    end

    context 'gifting beers' do 
      it 'can gift a beer from one user to another' do 
        user = create(:user, brubank: 10, beers_drunk: 2)
        user2 = create(:user, brubank: 10, beers_drunk: 2)
        beer_params = {gift: 'beer'}
        headers = {'HTTP_STRAVA_UID' => "#{user.strava_uid}", 'HTTP_RECIPIENT_UID' => "#{user2.strava_uid}"}
        patch "/api/v1/user", headers: headers, params: beer_params

        expect(response).to be_successful
        expect(response.status).to eq(200)

        user = JSON.parse(response.body, symbolize_names: true)
        expect(user[:data][:attributes][:brubank]).to eq(9)
        expect(User.find(user2.id).brubank).to eq(11)
      end

      it 'returns a 400 status if gifting a bru and recipient headers are missing' do 
        user = create(:user, brubank: 0)
        beer_params = {drank: 'beer'}
        headers = {'HTTP_STRAVA_UID' => user.strava_uid}
        patch '/api/v1/user', params: beer_params, headers: headers

        expect(response.status).to eq(400)
        expect(response.body.include?('NOT ENOUGH BEERS')).to eq true
      end

      it 'returns a 400 status if headers are missing when deleting a brü' do
        beer_params = {gift: 'beer'}
        patch '/api/v1/user', params: beer_params
  
        expect(response.status).to eq(400)
        expect(response.body.include?('MISSING HEADERS')).to eq true
      end
    end
  end 
end