class ActivitySerializer
  include JSONAPI::Serializer
  attributes :date, :title

  attribute :miles do |obj|
     obj.distance/2000
  end

  attribute :calories_burned do |obj|
    (obj.distance/2000).round(3) * 50
  end

  attribute :gas_money_saved do |obj|
    ((obj.distance/2000) / 25 * obj.gas_price).round(4)
  end
  
  attribute :beers_banked do |obj|
    ((obj.distance/2000) / 25 * 3.228 /4.25).round(4)
  end
end
