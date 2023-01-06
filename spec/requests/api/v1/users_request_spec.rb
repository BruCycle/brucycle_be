RSpec.describe 'Users API' do
  describe '/api/v1/user' do
    it 'returns the user and following info' do
      user = create(:user)
      create_list(:activity, 5, user_id: user.id)
      headers = {'STRAVA_UID' => "#{user.strava_uid}", 'STRAVA_TOKEN' => "#{ENV['strava_token']}"}
      get '/api/v1/user', headers: headers

      athlete = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(athlete).to be_a Hash

      attrs = athlete[:data][:attributes]
      expect(attrs).to be_a Hash
      expect(attrs).to have_key(:username)
      expect(attrs[:username]).to be_a(String)
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
      headers = {'STRAVA_UID' => "123", 'STRAVA_TOKEN' => "#{ENV['strava_token']}"}
      get '/api/v1/user', headers: headers

      athlete = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(athlete).to be_a Hash
    end
    
    xit 'returns a 404 status if no headers are included' do
      get '/api/v1/user'

      expect(response.status).to eq(400)
    end

    it 'edits the user\'s username' do
      user = create(:user, username: 'Homer')
      user_params = {username: 'Bart'}
      headers = {'STRAVA_UID' => "#{user.strava_uid}"}
      patch "/api/v1/user", headers: headers, params: user_params

      expect(response).to be_successful
      expect(response.status).to eq(200)

      user = JSON.parse(response.body, symbolize_names: true)
      expect(user[:data][:attributes][:username]).to_not eq('Homer')
      expect(user[:data][:attributes][:username]).to eq('Bart')
    end

    xit 'deletes a beer from brubank and adds a beer to beers drunk' do
      user = create(:user, brubank: 10, beers_drunk: 2)
      beer_params = {drank: 'beer'}
      headers = {'STRAVA_UID' => "#{user.strava_uid}"}
      patch "/api/v1/user", headers: headers, params: beer_params

      expect(response).to be_successful
      expect(response.status).to eq(200)

      user = JSON.parse(response.body, symbolize_names: true)
      expect(user[:data][:attributes][:brubank]).to eq(9)
      expect(user[:data][:attributes][:beers_drunk]).to eq(3)
    end

    xit 'returns a 404 status if no query params are included' do
      headers = {'STRAVA_UID' => "#{user.strava_uid}"}
      patch '/api/v1/activities', headers: headers
      

      expect(response.status).to eq(400)
    end
  end 
end