class Hand < ApplicationRecord
  has_many :cards, dependent: :destroy
  attr_accessor :face
  def check_hand_cards_number
    if cards.count == 5
      self.complete = true
      self.save
      HandChecker.new(self).check_type_of_hand
    end
  end
end
