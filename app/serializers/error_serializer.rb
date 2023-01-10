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
            "message": "Please include correct headers",
            "code": 400
          }
        ]
      }
  end

  def self.not_enough_beers
    {
      'errors': [
        {
          "status": 'NOT ENOUGH BEERS',
          "message": "User needs to more beers in the brubank before gifting or drinking a beer",
          "code": 400
        }
      ]
    }
  end
end 