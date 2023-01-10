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

    describe '#remove_beer_from_brubank' do
      it 'deletes a beer from the users brubank' do
        user = create(:user, brubank: 10, beers_drunk: 33)
        user.remove_beer_from_brubank
        expect(user.brubank).to eq(9)
      end
    end

    describe '#add_beer_to_brubank' do
      it 'adds a beer to a users brubank' do
        user = create(:user, brubank: 10, beers_drunk: 33)
        user.add_beer_to_brubank
        expect(user.brubank).to eq(11)
      end
    end

    describe '#gift_beer' do
      it 'deletes a beer from the users brubank and adds a beer to a recipeints brubank' do
        user = create(:user, brubank: 10)
        user2 = create(:user, brubank: 1)
        user.gift_beer(user2)
        expect(user.brubank).to eq(9)
        expect(user2.brubank).to eq(2)
      end

      it 'returns error if user does not enough beers in brubank to gift' do
        user = create(:user, brubank: 0)
        user2 = create(:user, brubank: 2)
        expect(user.gift_beer(user2)).to eq("Not enough brü's, bro")
        expect(user.brubank).to eq(0)
        expect(user2.brubank).to eq(2)
      end
    end
  end
end
