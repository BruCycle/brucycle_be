FactoryBot.define do
  factory :user do
    strava_uid { "#{Faker::Number.number(digits: 10)}" }
    brubank { 0 }
    beers_drunk { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    beers_earned { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
  end
end
