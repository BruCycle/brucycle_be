class GasBuddyService
  def self.conn
    Faraday.new(url: 'https://www.gasbuddy.com')
  end
  
  def self.get_gas_price(latitude, longitude)
    response = conn.post("/gaspricemap/county?lat=#{latitude.to_i}&lng=#{longitude.to_i}&usa=true")
    JSON.parse(response.body, symbolize_names: true)
  end
end