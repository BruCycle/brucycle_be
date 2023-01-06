class User < ApplicationRecord
  has_many :activities

  def drank_beer
    self.brubank -= 1
    self.beers_drunk += 1
  end
end
