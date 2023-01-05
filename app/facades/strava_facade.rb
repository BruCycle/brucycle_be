class StravaFacade
  def self.athlete(token)
    json = StravaService.get_athlete(token)
    User.create(strava_uid: json[:id], username: json[:username])
  end

  def self.athlete_activities(token)
    json = StravaService.get_athlete_activities(token)
  
    json.map do |activity|
      Activity.create(
        strava_id: activity[:id],
        date: activity[:start_date],
        title: activity[:name],
        distance: activity[:distance],
        latitude: activity[:start_latlng][0],
        longitude: activity[:start_latlng][1]
      )
    end
  end
end