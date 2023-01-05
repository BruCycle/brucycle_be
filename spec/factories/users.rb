FactoryBot.define do
  factory :user do
    strava_uid { "MyString" }
    username { "MyString" }
    brubank { 1.5 }
    beers_drunk { 1.5 }
    beers_earned { 1.5 }
  end
end
