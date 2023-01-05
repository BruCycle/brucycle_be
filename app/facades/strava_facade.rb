class StravaFacade
  def self.athlete_activities(token)
    json = StravaService.get_athlete_activities(token)
    json.map do |activity|
      Activity.new(activity)
    end
  end
end