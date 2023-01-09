class User < ApplicationRecord
  has_many :activities

  def drank_beer
    self.update(brubank: self.brubank - 1)
    self.update(beers_drunk: self.beers_drunk + 1)
  end
end
