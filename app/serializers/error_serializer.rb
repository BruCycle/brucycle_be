class ErrorSerializer
  def self.missing_params
    {
      'errors': [
        {
          "status": 'MISSING PARAMS',
          "message": "Please include correct params",
          "code": 400
        }
      ]
    }
  end

  def self.missing_headers
      {
        'errors': [
          {
            "status": 'MISSING HEADERS',
            "message": "Please include correct params",
            "code": 400
          }
        ]
      }
  end
end 