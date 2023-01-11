class Api::V1::UsersController < ApplicationController
  before_action :find_user

  def show
    if @user.nil?
      StravaFacade.athlete(request.headers[:HTTP_STRAVA_TOKEN]) 
      find_user
    end
    render json: UserSerializer.new(@user)
  end

  def update
    return render json: ErrorSerializer.not_enough_beers, status: 400 if @user.brubank < 1

    @user.drank_beer if params[:drank]
    @user.gift_beer(User.find_by(strava_uid: request.headers[:HTTP_RECIPIENT_UID])) if params[:gift]
    render json: UserSerializer.new(@user)
  end

  private
  def verify_headers
    if request.headers[:HTTP_STRAVA_TOKEN].nil? || request.headers[:HTTP_STRAVA_UID].nil?
      render json: ErrorSerializer.missing_headers, status: 400
    end
  end

  def verify_params
    if params[:drank].nil? && params[:gift].nil?
      render json: ErrorSerializer.missing_params, status: 400
    elsif request.headers[:HTTP_RECIPIENT_UID].nil? && params[:gift] == 'beer'
      render json: ErrorSerializer.missing_headers, status: 400
    elsif request.headers[:HTTP_STRAVA_UID].nil?
      render json: ErrorSerializer.missing_headers, status: 400
    end
  end

  def verify_type
    verify_params if params[:action] == 'update'
    verify_headers if params[:action] == 'show'
  end

  def find_user
    verify_type
    @user = User.find_by(strava_uid: request.headers[:HTTP_STRAVA_UID])
  end
end