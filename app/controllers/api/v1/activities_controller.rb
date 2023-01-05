class Api::V1::ActivitiesController < ApplicationController
  before_action :find_activities

  def index
    render json: ActivitySerializer.new(@activities)
  end

  private

  def find_activities
    @activities = Activity.where(strava_uid: request.headers[:STRAVA_UID])
    @activities = StravaFacade.athlete_activities(request.headers[:STRAVA_TOKEN]) if @activities.empty?
  end
end