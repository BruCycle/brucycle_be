class ActivitySerializer
  include JSONAPI::Serializer
  attributes :date, :title, :calories_burned, :gas_money_saved, :beers_banked

  attribute :miles do |obj|
     obj.to_miles
  end
end
