class PagesController < ApplicationController
  def home
    @card = Card.new
  end
end
