require 'rails_helper'

RSpec.describe 'Activities API' do
  describe '/api/v1/activities' do 
    it 'sends a list of users activities' do
      StravaFacade.athlete(ENV['strava_token']) 
      headers = {'STRAVA_UID' => 112175675, 'STRAVA_TOKEN' => "#{ENV['strava_token']}"}
      get '/api/v1/activities', headers: headers

      activities = JSON.parse(response.body, symbolize_names: true)
      expect(response).to be_successful
      expect(activities).to be_a(Hash)
      expect(activities[:data]).to be_an(Array)
      expect(activities[:data].count).to eq(2)
      activities[:data].each do |activity|
        expect(activity[:attributes]).to have_key(:date)
        expect(activity[:attributes][:date]).to be_a(String)
        expect(activity[:attributes]).to have_key(:title)
        expect(activity[:attributes][:title]).to be_a(String)
        expect(activity[:attributes]).to have_key(:miles)
        expect(activity[:attributes][:miles]).to be_a(Float)
        expect(activity[:attributes]).to have_key(:calories_burned)
        expect(activity[:attributes][:calories_burned]).to be_a(Float)
        expect(activity[:attributes]).to have_key(:gas_money_saved)
        expect(activity[:attributes][:gas_money_saved]).to be_a(Float)
        expect(activity[:attributes]).to have_key(:beers_banked)
        expect(activity[:attributes][:beers_banked]).to be_a(Float)
      end
    end

    xit 'returns a 400 status if no headers are included' do
      get '/api/v1/activities'

      expect(response.status).to eq(400)
    end

    xit 'updates the db users activities if there are new Strava activities' do
      user = create(:user, strava_uid: '112175675')
      create_list(:activity, 3, strava_uid: '112175675', user_id: user.id)
      headers = {'STRAVA_UID' => 112175675, 'STRAVA_TOKEN' => "#{ENV['strava_token']}"}
      get '/api/v1/activities', headers: headers

      activities = JSON.parse(response.body, symbolize_names: true)
      
      expect(response).to be_successful
      expect(activities.count).to eq(5)
    end

    it 'updates the db users activities if there are new Strava activities' do
      StravaFacade.athlete(ENV['strava_token'])
      headers = {'STRAVA_UID' => 112175675, 'STRAVA_TOKEN' => "#{ENV['strava_token']}"}
      get '/api/v1/activities', headers: headers
      get '/api/v1/activities', headers: headers
      activities = JSON.parse(response.body, symbolize_names: true)
      
      expect(activities[:data].count).to eq(2)
    end
  end
end