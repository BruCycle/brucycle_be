class User < ApplicationRecord
  has_many :activities

  def drank_beer
    self.update(brubank: self.brubank - 1)
    self.update(beers_drunk: self.beers_drunk + 1)
  end

  def remove_beer_from_brubank
    self.update(brubank: self.brubank - 1)
  end

  def add_beer_to_brubank
    self.update(brubank: self.brubank + 1)
  end

  def gift_beer(recipient)
    if self.brubank >= 1
      self.remove_beer_from_brubank & recipient.add_beer_to_brubank
    else 
      "Not enough brü's, bro"
    end
  end
end