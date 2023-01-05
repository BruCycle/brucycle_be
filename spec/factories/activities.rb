FactoryBot.define do
  factory :activity do
    date { "2023-01-04 15:59:28" }
    title { "MyString" }
    distance { 1.5 }
    calories_burned { 1.5 }
    gas_money_saved { 1.5 }
    beers_banked { 1.5 }
    latitude { 35.66 }
    longitude { -135.66 }
    strava_id { "133" }
  end
end
