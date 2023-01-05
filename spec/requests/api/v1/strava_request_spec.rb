require 'rails_helper'

RSpec.describe 'Strava API' do
  describe '/api/v1/athlete' do
    it 'returns the athlete and following info' do
      user = create(:user)
      create_list(:activity, 5, user_id: user.id)
      
      get api_v1_user_path(user)

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
  end 

  describe '/api/v1/activities' do 
    it 'sends a list of users activities' do 
      get api_v1_activities_path
       
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
 end
end