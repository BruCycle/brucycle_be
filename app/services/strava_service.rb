class StravaService
  def self.conn(token)
    Faraday.new(url: 'https://www.strava.com') do |f|
      f.headers['Authorization'] = "Bearer #{token}"
    end
  end

  def self.get_athlete_activities(token)
    response = conn(token).get('/api/v3/athlete/activities')
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_athlete(token)
    response = conn(token).get('/api/v3/athlete')
    JSON.parse(response.body, symbolize_names: true)
  end
end