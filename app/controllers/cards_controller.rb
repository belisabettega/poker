class CardsController < ApplicationController
  def new
    @card = Card.new
  end
  def create
    binding.pry
    @card = Card.new(card_params)

    if @card.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  private
  def card_params
    params.require(:card).permit(:face, :suit)
  end
end
