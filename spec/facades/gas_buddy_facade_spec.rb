require 'rails_helper'

RSpec.describe GasBuddyFacade do
  describe 'class methods' do
    describe '.get_gas_price' do
      it 'returns the gas price of a specific latitude and longitude' do
        gas_price = GasBuddyFacade.get_gas_price(33.33, -110.23)
        expect(gas_price).to be_a(Float)
      end
    end
  end
end