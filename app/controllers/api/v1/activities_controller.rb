class Api::V1::ActivitiesController < ApplicationController
  before_action :find_activities

  def index
    render json: ActivitySerializer.new(@activities)
  end

  private

  def find_activities
    check_for_activities
    @activities = Activity.where(strava_uid: request.headers[:STRAVA_UID]).order(:date)
  end

  def check_for_activities
    StravaFacade.athlete_activities(request.headers[:STRAVA_TOKEN]) 
  end
end