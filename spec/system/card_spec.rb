require 'rails_helper'

RSpec.describe 'Card', type: :system do
  before do
    driven_by(:rack_test)
  end
  context 'when loading the root path' do
    it 'shows the name of the app' do
      visit '/'
      expect(page).to have_content('Poker hands app')
    end
  end
end