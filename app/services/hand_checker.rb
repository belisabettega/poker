class HandChecker
  def initialize(hand)
    @hand = hand
  end

  def check_type_of_hand
    array_faces = []
    array_suits = []
    @hand.cards.each do |card|
      tranform_faces_into_integers(card)
      card.save
      array_faces << card.face
      array_suits << card.suit
    end
    if number_of_suits?(1, array_suits) && straight_flush?(array_faces)
      @hand.name = "Straight Flush"
      @hand.save
    elsif number_of_suits?(4, array_suits) &&  face_repeats?(4, array_faces)
      @hand.name = "Four of a kind"
      @hand.save
    elsif number_of_suits?(3, array_suits) &&  face_repeats?(3, array_faces) && face_repeats?(2, array_faces)
      @hand.name = "Full House"
      @hand.save
    elsif number_of_suits?(1, array_suits)
      @hand.name = "Flush"
      @hand.save
    elsif check_if_is_sequential(array_faces)
      @hand.name = "Straight"
      @hand.save
    elsif  face_repeats?(3, array_faces)
      @hand.name = "Three of a kind"
      @hand.save
    elsif two_pairs?(array_faces)
      @hand.name = "Two pair"
      @hand.save
    elsif face_repeats?(2, array_faces)
      @hand.name = "One pair"
      @hand.save
    else
      @hand.name = "High card"
      @hand.save
    end
  end

  private

  def number_of_suits?(number, array_suits)
    array_suits.uniq.count == number
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
    return unless array_faces.uniq.count == 5
    straight_flush = false
    if array_faces.include?("1")
      check_with_one_value = check_if_is_sequential(array_faces)
      array_faces.delete(1)
      array_with_fourteen = array_faces << 14
      check_with_fourteen_value = check_if_is_sequential(array_with_fourteen)
      straight_flush = true if check_with_one_value || check_with_fourteen_value
    elsif
      straight_flush = check_if_is_sequential(array_faces)
    end
    straight_flush
  end

  def check_if_is_sequential(array)
    return unless array.uniq.count == 5
    sequential = true
    array.map!(&:to_i).sort!.each_with_index do |card_face, index|
      card_face_after_this_one = array[index + 1].to_i
      unless card_face_after_this_one == 0
        sequential = false if card_face.to_i + 1 != card_face_after_this_one.to_i
      end
    end
    sequential
  end

  def two_pairs?(array_faces)
    hash_face_cards = array_faces.each_with_object(Hash.new(0)) { |face, hash| hash[face] += 1 }
    faces_that_repeat_twice = hash_face_cards.select! {|k,v| v == 2}
    faces_that_repeat_twice&.count == 2
  end

  def face_repeats?(number_of_repetitions, array_faces)
    hash_face_cards = array_faces.each_with_object(Hash.new(0)) { |face, hash| hash[face] += 1 }
    hash_face_cards.any? {|k,v| v == number_of_repetitions}
  end
end