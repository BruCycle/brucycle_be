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
        json = File.read('spec/fixtures/gas_price.json')
        
        stub_request(:post, "https://www.gasbuddy.com/gaspricemap/county")
          .with(query: hash_including({}))
          .to_return(status: 200, body: json)

        results = GasBuddyService.get_gas_price(35.100, -105.86)
        expect(results).to be_an Array
        expect(results[0]).to be_a Hash
    
        expect(results[0]).to have_key(:Id)
        expect(results[0]).to have_key(:State)
        expect(results[0]).to have_key(:Distance)  
        expect(results[0]).to have_key(:Price)
      end
    end
  end
end