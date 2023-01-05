class Api::V1::UsersController < ApplicationController
  before_action :find_user

  def show
    if @user.nil?
      StravaFacade.athlete(params[:token]) 
      @user = User.find_by(strava_uid: params[:uid])
    end
    render json: UserSerializer.new(@user)
  end

  private

  def find_user
    @user = User.find_by(strava_uid: params[:uid])
  end
end