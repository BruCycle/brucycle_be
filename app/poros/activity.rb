class Activity
  attr_reader :strava_id, :date, :title, :distance, :latitude, :longitude

  def initialize(data)
    @strava_id = data[:id]
    @date = data[:start_date]
    @title = data[:name]
    @distance = data[:distance]
    @latitude = data[:start_latlng][0]
    @longitude = data[:start_latlng][1]
  end
end