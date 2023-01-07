class Activity < ApplicationRecord
    belongs_to :user
    after_create :calc_calories_burned

    def self.gas_money_saved
        sum(:gas_money_saved)
    end

    def self.calories_burned
        sum(:calories_burned).round(3)
    end

    def self.miles_biked
        sum(:distance) / 1600
    end

    def gas_price
        if latitude.nil? || longitude.nil?
            3.228 
        else
            GasBuddyFacade.get_gas_price(latitude, longitude)
        end
    end

    def calc_calories_burned
        update_attribute(:calories_burned, ((distance/1600) * 50).round(3))
    end
end