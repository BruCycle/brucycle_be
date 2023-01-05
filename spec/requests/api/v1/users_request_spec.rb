RSpec.describe 'Users API' do
  describe '/api/v1/user' do
    it 'returns the user and following info' do
      user = create(:user)
      create_list(:activity, 5, user_id: user.id)

      get "/api/v1/user?uid=#{user.strava_uid}&token=#{ENV['strava_token']}"

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
      get "/api/v1/user?uid=123&token=#{ENV['strava_token']}"

      athlete = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(athlete).to be_a Hash
    end
  end 
end