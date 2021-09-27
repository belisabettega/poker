require 'rails_helper'

RSpec.describe HandChecker, type: :model do
  let(:hand)     { FactoryBot.create(:hand) }
  let(:card_1)   { FactoryBot.build(:card, hand: hand) }
  let(:card_2)   { FactoryBot.build(:card, hand: hand) }
  let(:card_3)   { FactoryBot.build(:card, hand: hand) }
  let(:card_4)   { FactoryBot.build(:card, hand: hand) }
  let(:card_5)   { FactoryBot.build(:card, hand: hand) }

  describe '#check_type_of_hand' do
    it 'names the hand type' do
      HandChecker.new(hand).check_type_of_hand
      expect(hand.name).to eq("Straight")
    end
  end
end