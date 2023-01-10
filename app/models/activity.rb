class Activity < ApplicationRecord
	belongs_to :user
	after_create :calc_calories_burned, :calc_gas_money_saved, :calc_beers_banked, :add_to_my_brubank

	def self.gas_money_saved
		sum(:gas_money_saved).round(4)
	end

	def self.calories_burned
		sum(:calories_burned).round(3)
	end

	def self.miles_biked
		(sum(:distance) / 1600).round(3)
	end

	def gas_price
		if latitude.nil? || longitude.nil?
			3.228 
		else
			GasBuddyFacade.get_gas_price(latitude, longitude)
		end
	end

	def add_to_my_brubank
		new_amount = beers_banked + user.brubank
		user.update_attribute(:brubank, new_amount)
	end

	def calc_calories_burned
		update_attribute(:calories_burned, ((distance/1600) * 50).round(3))
	end

	def calc_gas_money_saved
		update_attribute(:gas_money_saved, ((distance/1600) / 25 * gas_price).round(4))
	end

	def calc_beers_banked 
		update_attribute(:beers_banked, ((distance/1600) / 25 * gas_price / 4.25).round(4))
	end
end