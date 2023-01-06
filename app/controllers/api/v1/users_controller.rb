class Api::V1::UsersController < ApplicationController
  before_action :find_user

  def show
    if @user.nil?
      StravaFacade.athlete(request.headers[:STRAVA_UID]) 
      find_user
    end
    render json: UserSerializer.new(@user)
  end

  def update
    @user.drank_beer
    render json: UserSerializer.new(@user)
  end

  private

  def verify_headers
    if request.headers[:STRAVA_TOKEN].nil? || request.headers[:STRAVA_UID].nil?
      render json: ErrorSerializer.missing_headers, status: 400
    end
  end

  def verify_params
    if request.headers[:STRAVA_UID].nil? || params[:drank].nil?
      render json: ErrorSerializer.missing_params, status: 400
    end
  end

  def verify_type
    verify_params if params[:action] == 'update'
    verify_headers if params[:action] == 'show'
  end

  def find_user
    verify_type
    @user = User.find_by(strava_uid: request.headers[:STRAVA_UID])
  end
end