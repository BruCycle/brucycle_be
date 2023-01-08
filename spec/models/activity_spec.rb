require 'rails_helper'

RSpec.describe Activity do
  describe 'relationships' do
    it { should belong_to :user }
  end

  describe 'class methods' do
    before do
      user = create(:user)
      create_list(:activity, 3, distance: 4, user_id: user.id)
      create_list(:activity, 3, distance: 2, user_id: user.id)
    end
    describe '.gas_money_saved' do
      it 'totals all activities gas money saved' do
        expect(Activity.gas_money_saved).to eq(0.0015)
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
      @activity = create(:activity, user_id: @user.id, latitude: 39, longitude: -122, distance: 55)
      @activity2 = create(:activity, user_id: @user.id, distance: 100)
      @no_lat = create(:activity, user_id: @user.id, latitude: nil)
      @no_lng = create(:activity, user_id: @user.id, longitude: nil)
    end
    describe '#gas_price' do
      it 'returns the gas price of the activity\'s latitude and longitude' do
        VCR.insert_cassette 'gas_buddy_call'
        expect(@activity.gas_price).to_not eq(3.228)
        VCR.eject_cassette
      end

      it 'returns the national gas average if either latitude or longitude are empty' do
        expect(@no_lat.gas_price).to eq(3.228)
        expect(@no_lng.gas_price).to eq(3.228)
      end

      it 'updates the attribute for the calories burned' do 
        expect(@activity.calc_calories_burned).to eq(true)
        expect(@activity2.calc_calories_burned).to eq(true)
      end

      it 'updates the attribute for the gas money saved' do 
        expect(@activity.calc_gas_money_saved).to eq(true)
        expect(@activity2.calc_gas_money_saved).to eq(true)
      end

      it 'updates the attribute for beers banked' do 
        expect(@activity.beers_banked).to eq(0.001)
        expect(@activity2.beers_banked).to eq(0.0019)
      end
    end
  end
end