class ActivitySerializer
  include JSONAPI::Serializer
  attributes :date, :title

  attribute :miles do |object|
     object.distance/2000
  end

  attribute :calories_burned do |object|
    (object.distance/2000).round(3) * 50
  end

  attribute :gas_money_saved do |object|
    ((object.distance/2000) / 25 * 3.228).round(4)
  end
  
  attribute :beers_banked do |object|
    ((object.distance/2000) / 25 * 3.228 /4.25).round(4)
  end
end
