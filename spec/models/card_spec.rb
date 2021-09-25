require 'rails_helper'

RSpec.describe Card, type: :model do
  context 'when creating a card' do
    it 'validates the face attribute' do
      card = Card.new(face: "1")
      card.validate
      expect(card.errors[:face]).to include("must be a number between 2 to 10 or the following characters: A, J, Q or K - the value 1 is not valid")
    end
    it 'validates the suit attribute' do
      card = Card.new(suit: "a")
      card.validate
      expect(card.errors[:suit]).to include("must be one of the following characters: H, D, C or S - the value a is not valid")
    end
  end
end
