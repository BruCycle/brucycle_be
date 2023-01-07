require 'rails_helper'

RSpec.describe StravaFacade do
  describe 'class methods' do
    describe '.athlete_activities' do
      it 'returns athlete activities' do
        StravaFacade.athlete(ENV['strava_token'])
        activities = StravaFacade.athlete_activities(ENV['strava_token'])
    
        expect(activities).to be_an Array
        
        activity = activities[0]
        expect(activity.distance).to eq(37.0)
      end
    end

    describe '.athlete' do
      it 'returns an athletes info' do
        athlete = StravaFacade.athlete(ENV['strava_token'])

        expect(athlete.username).to eq('sean_culliton')
      end
    end
  end
end