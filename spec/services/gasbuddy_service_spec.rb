require 'rails_helper'

RSpec.describe 'GasBuddyService' do
  describe 'class methods' do
    describe '.conn' do
      it 'connects with the GasBuddy API' do
        connection = GasBuddyService.conn
        expect(connection.params).to be_a Hash
       
      end
    end
    describe '.get_gas_price' do
      it 'returns gas price' do
        results = GasBuddyService.get_gas_price(35.100, -105.86)
        expect(results).to be_an Array
        expect(results).to eq([{:Distance=>36.36, :Id=>2091, :Name=>"Santa Fe", :Price=>2.993, :State=>"NM"}])
    
      end
    end
  end
end