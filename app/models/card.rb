class Card < ApplicationRecord
  validates :face, inclusion: { in: %w(A 2 3 4 5 6 7 8 9 10 J Q K), message: "must be a number between 2 to 10 or the following characters: A, J, Q or K - the value %{value} is not valid" }
  validates :suit, inclusion: { in: %w(H D C S), message: "must be one of the following characters: H, D, C or S - the value %{value} is not valid" }
end
