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
    @user = User.update(@user.id, user_params)
    render json: UserSerializer.new(@user)
  end

  private

  def find_user
    @user = User.find_by(strava_uid: request.headers[:STRAVA_UID])
  end

  def user_params
    params.permit(:username)
  end
end