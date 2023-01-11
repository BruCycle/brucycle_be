class Api::V1::ActivitiesController < ApplicationController
  before_action :verify_headers, :find_activities

  def index
    render json: ActivitySerializer.new(@activities)
  end

  private
  def verify_headers
    if request.headers[:HTTP_STRAVA_TOKEN].nil? || request.headers[:HTTP_STRAVA_UID].nil?
      render json: ErrorSerializer.missing_headers, status: 400
    end
  end
     
  def find_activities
    check_for_activities
    @activities = Activity.find_my_activities(request.headers[:HTTP_STRAVA_UID])
  end

  def check_for_activities
    StravaFacade.athlete_activities(request.headers[:HTTP_STRAVA_TOKEN]) 
  end
end