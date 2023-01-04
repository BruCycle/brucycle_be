require 'rails_helper'

RSpec.describe StravaService do
  describe 'class methods' do
    describe '.conn' do
      it 'connects with the Strava API' do
        connection = StravaService.conn('2be81132c00f4b35dc738cf69969065745987e9e')
        expect(connection.params).to be_a Hash
        expect(connection.headers).to be_a Hash
        expect(connection.headers).to have_key "Authorization"
      end
    end

    describe '.get_athlete_activities' do
      it 'returns athletes activities' do
        activities = StravaService.get_athlete_activities('2be81132c00f4b35dc738cf69969065745987e9e')
        expect(activities).to be_an Array

        activity = activities[0]
        expect(activity).to have_key(:name)
        expect(activity[:name]).to be_a(String)
        expect(activity).to have_key(:id)
        expect(activity[:id]).to be_an(Integer)
        expect(activity).to have_key(:start_date)
        expect(activity[:start_date]).to be_a(String)
        expect(activity).to have_key(:distance)
        expect(activity[:distance]).to be_a(Float)
        expect(activity).to have_key(:start_latlng)
        expect(activity[:start_latlng]).to be_an(Array)
        expect(activity).to have_key(:end_latlng)
        expect(activity[:end_latlng]).to be_an(Array)
      end
    end
  end
end