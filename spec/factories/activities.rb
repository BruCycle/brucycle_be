FactoryBot.define do
  factory :activity do
    date { "2023-01-04 15:59:28" }
    title { "MyString" }
    miles { 1.5 }
    calories_burned { 1.5 }
    gas_money_saved { 1.5 }
    beers_banked { 1.5 }
  end
end
