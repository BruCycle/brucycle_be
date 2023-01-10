require 'rails_helper'

RSpec.describe StravaFacade do
  before(:each) do 
    @json = File.read('spec/fixtures/gas_price.json')
        
    stub_request(:post, "https://www.gasbuddy.com/gaspricemap/county")
      .with(query: hash_including({}))
      .to_return(status: 200, body: @json)
  end

  describe 'class methods' do
    describe '.athlete_activities' do
      it 'returns athlete activities' do
        VCR.insert_cassette 'strava_facade_athlete_activities'
        StravaFacade.athlete(ENV['strava_token'])
        activities = StravaFacade.athlete_activities(ENV['strava_token'])
    
        expect(activities).to be_an Array
        
        activity = activities[0]
        expect(activity.distance).to eq(19626.7)
        VCR.eject_cassette
      end
    end

    describe '.athlete' do
      it 'returns an athletes info' do
        VCR.insert_cassette 'strava_facade_athlete'
        athlete = StravaFacade.athlete(ENV['strava_token'])

        expect(athlete.strava_uid).to eq('8040180')
        VCR.eject_cassette
      end
    end
  end
end