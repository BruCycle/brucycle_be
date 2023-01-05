class UserSerializer
  include JSONAPI::Serializer
  attributes :username, :beers_drunk

  attribute :brubank

  attribute :tot_gas_money_saved do |obj|
    obj.activities.gas_money_saved
  end

  attribute :tot_calories_burned do |obj|
    obj.activities.calories_burned
  end

  attribute :tot_miles_biked do |obj|
    obj.activities.miles_biked
  end
end
