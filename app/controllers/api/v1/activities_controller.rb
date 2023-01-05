class Api::V1::ActivitiesController < ApplicationController
  def index
    activities = Activity.where(strava_uid: params[:uid])
    activities = StravaFacade.athlete_activities(params[:token]) if activities.empty?
    render json: ActivitySerializer.new(activities)
  end
end