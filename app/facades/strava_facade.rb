class StravaFacade
  def self.athlete(token)
    json = StravaService.get_athlete(token)
    User.create(strava_uid: json[:id])
  end

  def self.athlete_activities(token)
    json = StravaService.get_athlete_activities(token)
    json.map do |activity|
      if Activity.find_by(strava_id: activity[:id]).nil? && activity[:type] == 'Ride'
        Activity.create(
          strava_uid: activity[:athlete][:id],
          strava_id: activity[:id],
          date: activity[:start_date],
          title: activity[:name],
          distance: activity[:distance],
          latitude: activity[:start_latlng][0],
          longitude: activity[:start_latlng][1],
          user_id: User.find_by(strava_uid: activity[:athlete][:id]).id
        )
      end
    end
  end
end