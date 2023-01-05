FactoryBot.define do
  factory :activity do
    date { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    title { Faker::TvShows::Simpsons.location }
    distance { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    calories_burned { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
    gas_money_saved { Faker::Number.decimal(l_digits: 1, r_digits: 2) }
    beers_banked { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    latitude { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    longitude { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
    strava_uid { "#{Faker::Number.number(digits: 10)}" }
    user
  end
end
