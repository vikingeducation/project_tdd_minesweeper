# spec/player_spec.rb

require 'player'
include Minesweeper

describe "Player" do
  let (:player) { Player.new }

  describe "#initialize" do
    it "creates an instance of Player" do
      expect(player).to be_a(Player)
    end

    it "sets the player's last move to nil" do
      expect(player.last_move).to be_nil
    end

    it "sets the player's last coordinates chosen to nil" do
      expect(player.last_coords).to be_nil
    end
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