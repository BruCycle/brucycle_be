require 'rails_helper'

RSpec.describe Activity do
  describe 'relationships' do
    it { should belong_to :user }
  end

  before do
    user = create(:user)
    create_list(:activity, 3, distance: 4, user_id: user.id)
    create_list(:activity, 3, distance: 2, user_id: user.id)
  end

  describe 'class methods' do
    describe '.gas_money_saved' do
      it 'totals all activities gas money saved' do
        expect(Activity.gas_money_saved).to eq(0014526)
      end
    end

    describe '.calories_burned' do
      it 'totals all activities gas money saved' do
        expect(Activity.calories_burned).to eq(0.564)
      end
    end

    describe '.miles_biked' do
      it 'totals all activities gas money saved' do
        expect(Activity.miles_biked).to eq(0.01125)
      end
    end
  end

  describe 'instance methods' do
    before do
      @user = create(:user)
      @activity = create(:activity, user_id: @user.id)
      @no_lat = create(:activity, user_id: @user.id, latitude: nil)
      @no_lng = create(:activity, user_id: @user.id, longitude: nil)
    end
    describe '#gas_price' do
      it 'returns the gas price of the activity\'s latitude and longitude' do
        expect(@activity.gas_price).to_not eq(3.228)
      end

      it 'returns the national gas average if either latitude or longitude are empty' do
        expect(@no_lat.gas_price).to eq(3.228)
        expect(@no_lng.gas_price).to eq(3.228)
      end
    end
  end
end