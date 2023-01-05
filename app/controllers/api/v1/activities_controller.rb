class Api::V1::ActivitiesController < ApplicationController
  def index
    # new_activities = StravaFacade.athlete_activities(ENV['strava_token'])
    render json: ActivitySerializer.new(StravaFacade.athlete_activities(ENV['strava_token']))
  end
end