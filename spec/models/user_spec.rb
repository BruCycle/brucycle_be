require 'rails_helper'

RSpec.describe User do
  describe 'relationships' do
    it { should have_many :activities }
  end

  describe 'instance methods' do
    describe '#drank_beer' do
       it 'deletes a beer from the users brubank and adds a beer to the users beers drunk' do
        user = create(:user, brubank: 10, beers_drunk: 33)
        user.drank_beer
        expect(user.brubank).to eq(9)
        expect(user.beers_drunk).to eq(34)
       end
    end
  end
end
