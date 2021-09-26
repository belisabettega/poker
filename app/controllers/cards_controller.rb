class CardsController < ApplicationController
  def create
    @card = Card.new(card_params)
    @hand = Hand.find(params[:hand_id])
    @card.hand = @hand

    if @card.save
      @hand.check_hand_cards_number
      redirect_to hand_path(@hand)
    else
      render 'hands/show'
    end
  end

  private
  def card_params
    params.require(:card).permit(:face, :suit)
  end
end
