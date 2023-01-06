class ErrorSerializer
  def self.missing_headers
    {
      'errors': [
        {
          "status": 'MISSING HEADERS',
          "message": "Please include both STRAVA_UID and STRAVA_TOKEN",
          "code": 400
        }
      ]
    }
  end

  def self.missing_params

  end
end