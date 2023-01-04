require 'rails_helper'

RSpec.describe StravaFacade do
  describe 'class methods' do
    describe '.athlete_activities' do
      it 'returns athlete activities' do
        activities = StravaFacade.athlete_activities('2be81132c00f4b35dc738cf69969065745987e9e')
    
        expect(activities).to be_an Array
        
        activity = activities[0]
        expect(activity.distance).to eq(37.0)
      end
    end
  end
end