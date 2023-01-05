require 'rails_helper'

RSpec.describe 'Activities API' do 
  describe '/api/v1/activities' do 
    it 'sends a list of users activities' do 
     create_list(:activity, 5)
     
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