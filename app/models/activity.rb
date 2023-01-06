class Activity < ApplicationRecord
    belongs_to :user

    def self.gas_money_saved
        sum(:gas_money_saved)
    end

    def self.calories_burned
        sum(:calories_burned)
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
end