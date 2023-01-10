require 'rails_helper'

RSpec.describe 'Activities API' do
  before(:each) do 
    @json = File.read('spec/fixtures/gas_price.json')
        
    stub_request(:post, "https://www.gasbuddy.com/gaspricemap/county")
      .with(query: hash_including({}))
      .to_return(status: 200, body: @json)
  end
  
  describe '/api/v1/activities' do 
    it 'sends a list of users activities' do
      VCR.insert_cassette 'strava_facade_athlete_activities'
      StravaFacade.athlete(ENV['strava_token']) 
      headers = {'HTTP_STRAVA_UID' => 8040180, 'HTTP_STRAVA_TOKEN' => "#{ENV['strava_token']}"}
      get '/api/v1/activities', headers: headers
      
      activities = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(activities).to be_a(Hash)
      expect(activities[:data]).to be_an(Array)
      expect(activities[:data].count).to eq(10)
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
      VCR.eject_cassette
    end

    it 'returns a 400 status if no headers are included' do   
      get '/api/v1/activities'
      
      expect(response.status).to eq(400)
    end

    it 'updates the db users activities if there are new Strava activities' do
      VCR.insert_cassette 'strava_facade_athlete_activities'
      StravaFacade.athlete(ENV['strava_token'])
      headers = {'HTTP_STRAVA_UID' => 8040180, 'HTTP_STRAVA_TOKEN' => "#{ENV['strava_token']}"}
      get '/api/v1/activities', headers: headers
      VCR.eject_cassette

      VCR.insert_cassette 'strava_facade_athlete_activities'
      get '/api/v1/activities', headers: headers
      activities = JSON.parse(response.body, symbolize_names: true)
      expect(activities[:data].count).to eq(10)
      VCR.eject_cassette
    end
  end
end