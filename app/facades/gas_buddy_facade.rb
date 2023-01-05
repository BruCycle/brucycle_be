class GasBuddyFacade
  def self.get_gas_price(latitude, longitude)
    json = GasBuddyService.get_gas_price(latitude, longitude)
    json[0][:Price]
  end
end