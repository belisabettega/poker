class Card < ApplicationRecord
  FACES = %w(A 2 3 4 5 6 7 8 9 10 J Q K)
  SUITS = %w(H D C S)
  validates :face, inclusion: { in: FACES, message: "must be a number between 2 to 10 or the following characters: A, J, Q or K - the value %{value} is not valid" }
  validates :suit, inclusion: { in: SUITS, message: "must be one of the following characters: H, D, C or S - the value %{value} is not valid" }
  belongs_to :hand
end
