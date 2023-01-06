class GasBuddyFacade
  def self.get_gas_price(latitude, longitude)
    json = GasBuddyService.get_gas_price(latitude.to_i, longitude.to_i)
    json[0][:Price]
  end
end