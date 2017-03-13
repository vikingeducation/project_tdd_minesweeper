# spec/player_spec.rb

require 'player'
include Minesweeper

describe "Player" do

  describe "#initialize" do
    it "creates an instance of Player"

    it "sets the player's last move to nil"

    it "sets the player's last coordinates chosen to nil"
  end

  describe "#get_move" do
    it "prints a message asking the player for his move"

    it "accepts 'c' as a valid move (to clear a cell)"

    it "accepts 'f' as a valid move (to flag a cell)"

    it "accepts 'u' as a valid move (to unflag a cell)"

    it "accepts 'r' as a valid move (to reset the game)"

    it "accepts 'q' as a valid move (to quit the game)"

    it "prints an error message for all other moves"

    it "returns nil for invalid moves"
  end

  describe "#get_coords" do
    it "prints a message asking the player for the coordinates he wants to make a move at"

    it "accepts an input of 'x, y' as a valid coordinate, where 0 <= x <= rows - 1 and 0 <= y <= cols - 1"

    it "prints an error message for all other moves"

    it "returns nil for invalid coordinates"
  end
end