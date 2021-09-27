class Hand < ApplicationRecord
  has_many :cards, dependent: :destroy
  attr_accessor :face
  def check_hand_cards_number
    if cards.count == 5
      self.complete = true
      self.save
      check_type_of_hand
    end
  end

  def check_type_of_hand
    array_faces = []
    array_suits = []
    cards.each do |card|
      tranform_faces_into_integers(card)
      card.save
      array_faces << card.face
      array_suits << card.suit
    end
    if array_suits.uniq.count == 1 && straight_flush?(array_faces)
      self.name = "Straight Flush"
      self.save
    elsif array_suits.uniq.count == 4 &&  card_repeats?(4, array_faces)
      self.name = "Four of a kind"
      self.save
    elsif array_suits.uniq.count == 3 &&  card_repeats?(3, array_faces) && card_repeats?(2, array_faces)
      self.name = "Full House"
      self.save
    elsif array_suits.uniq.count == 1
      self.name = "Flush"
      self.save
    elsif check_if_is_sequential(array_faces)
      self.name = "Straight"
      self.save
    elsif  card_repeats?(3, array_faces)
      self.name = "Three of a kind"
      self.save
    elsif two_pairs?
      self.name = "Two pair"
      self.save
    elsif card_repeats?(2, array_faces)
      self.name = "One pair"
      self.save
    else
      self.name = "High card"
      self.save
    end
  end

  def tranform_faces_into_integers(card)
    case card.face
    when "A"
      card.face = "1"
    when "J"
      card.face = "11"
    when "Q"
      card.face = "12"
    when "K"
      card.face = "13"
    else
      card.face
    end
  end

  def straight_flush?(array_faces)
    if array_faces.include?("1")
      check_with_one_value = check_if_is_sequential(array_faces)
      array_faces.reject! { |face| face == "1" }
      array_faces << "14"
      check_with_fourteen_value = check_if_is_sequential(array_faces)
      check_with_one_value || check_with_fourteen_value
    elsif
      check_if_is_sequential(array_faces)
    end
  end

  def check_if_is_sequential(array)
    sequential = true
    array.sort!.each_with_index do |card_face, index|
      card_face_after_this_one = array[index + 1]
      unless card_face_after_this_one.blank?
        sequential = false if card_face.to_i + 1 != card_face_after_this_one.to_i
      end
    end
    sequential
  end

  def card_repeats?(number, array_faces)
    hash_face_cards = array_faces.each_with_object(Hash.new(0)) { |face, hash| hash[face] += 1 }
    hash_face_cards.any? {|k,v| v == number}
  end
end
