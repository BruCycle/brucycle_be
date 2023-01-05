class Activity < ApplicationRecord
    belongs_to :user

    def self.gas_money_saved
        sum(:gas_money_saved)
    end

    def self.calories_burned
        sum(:calories_burned)
    end

    def self.miles_biked
        sum(:distance) / 2000
    end
end