class Hand < ApplicationRecord
  has_many :cards, dependent: :destroy
  def check_hand_cards_number
    if cards.count == 5
      check_type_of_hand
    end
  end

  def tranform_faces_into_integers(card)
    case card.face
    when "A"
      card.face = 1
    when "J"
      card.face = 11
    when "Q"
      card.face = 12
    when "K"
      card.face = 13
    else
      card.face = card.face.to_i
    end
  end

  def check_type_of_hand
    byebug
    array_faces = []
    array_suits = []
    cards.each do |card|
      tranform_faces_into_integers(card)
      array_faces << card.face
      array_suits << card.suit
    end
    
    if array_suits.uniq.count == 1
      straight_flush?(array_faces)
    else
    end
  end

  def straight_flush?(array_faces)
    
  end
end
