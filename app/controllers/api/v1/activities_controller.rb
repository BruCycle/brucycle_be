class Api::V1::ActivitiesController < ApplicationController
  before_action :verify_headers, :find_activities

  def index
    render json: ActivitySerializer.new(@activities)
  end

  private
  def verify_headers
    if request.headers[:STRAVA_TOKEN].nil? || request.headers[:STRAVA_UID].nil?
      render json: ErrorSerializer.missing_headers, status: 400
    end
  end
     
  def find_activities
    @activities = Activity.where(strava_uid: request.headers[:STRAVA_UID])
    @activities = StravaFacade.athlete_activities(request.headers[:STRAVA_TOKEN]) if @activities.empty?
  end
end