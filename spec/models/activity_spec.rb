require 'rails_helper'

RSpec.describe Activity do
  describe 'relationships' do
    it { should belong_to :user }
  end

  before do
    user = create(:user)
    create_list(:activity, 3, gas_money_saved: 2.2, distance: 4, calories_burned: 1, user_id: user.id)
    create_list(:activity, 3, gas_money_saved: 4.3, distance: 2, calories_burned: 2, user_id: user.id)
  end

  describe 'class methods' do
    describe '.gas_money_saved' do
      it 'totals all activities gas money saved' do
        expect(Activity.gas_money_saved).to eq(19.5)
      end
    end

    describe '.calories_burned' do
      it 'totals all activities gas money saved' do
        expect(Activity.calories_burned).to eq(9)
      end
    end

    describe '.miles_biked' do
      it 'totals all activities gas money saved' do
        expect(Activity.miles_biked).to eq(0.009)
      end
    end
  end
end