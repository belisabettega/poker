require 'rails_helper'

RSpec.describe Hand, type: :model do
  let!(:hand)     { FactoryBot.create(:hand) }
  let!(:card_1)   { FactoryBot.create(:card, hand: hand) }
  let!(:card_2)   { FactoryBot.create(:card, hand: hand) }
  let!(:card_3)   { FactoryBot.create(:card, hand: hand) }
  let!(:card_4)   { FactoryBot.create(:card, hand: hand) }
  let!(:card_5)   { FactoryBot.create(:card, hand: hand) }

  context '#check_hand_cards_number' do
    it 'changes the hand status to complete' do
      hand.check_hand_cards_number
      expect(hand.complete).to eq(true)
    end
  end
end
