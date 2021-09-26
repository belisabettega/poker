class HandsController < ApplicationController
  attr_accessor :check_hand_cards_number
  def create
    @hand = Hand.create
    redirect_to hand_path(@hand)
  end
  def show
    @hand = Hand.find(params[:id])
    @card = Card.new
  end
end
