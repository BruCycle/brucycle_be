class Activity < ApplicationRecord
	belongs_to :user
	after_create :update_calories_burned, :update_gas_money_saved, :update_beers_banked, :add_to_my_brubank

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

	def update_calories_burned
		update_attribute(:calories_burned, calc_calories_burned.round(3))
	end

	def update_gas_money_saved
		update_attribute(:gas_money_saved, calc_gas_money_saved.round(4))
	end

	def update_beers_banked 
		update_attribute(:beers_banked, ((calc_gas_money_saved / 4.25) + (calc_calories_burned / 150)).round(4))
	end

	def calc_calories_burned
		((distance/1600) * 50)
	end

	def calc_gas_money_saved
		((distance/1600) / 25 * gas_price)
	end
end