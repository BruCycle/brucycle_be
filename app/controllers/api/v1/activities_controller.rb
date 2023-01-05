class Api::V1::ActivitiesController < ApplicationController
  def index
  
    render json: ActivitySerializer.new(StravaFacade.athlete_activities(ENV['strava_token']))
  end

end