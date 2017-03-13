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
    before(:each) do
      allow(player).to receive(:print).and_return(nil)
      allow(player).to receive(:puts).and_return(nil)
    end

    it "returns true for valid inputs ('c', 'f', 'u', or 'q')" do
      allow(player).to receive(:gets).and_return('C')
      expect(player.get_move).to be true
    
      allow(player).to receive(:gets).and_return('F')
      expect(player.get_move).to be true
    
      allow(player).to receive(:gets).and_return('U')
      expect(player.get_move).to be true
    
      allow(player).to receive(:gets).and_return('Q')
      expect(player.get_move).to be true
    end

    it "returns false for all other inputs" do
      allow(player).to receive(:gets).and_return('b')
      expect(player.get_move).to be false
    end

    it "sets @last_move to a valid move" do
      allow(player).to receive(:gets).and_return('c')
      player.get_move
      expect(player.last_move).to eq('c')

      allow(player).to receive(:gets).and_return('f')
      player.get_move
      expect(player.last_move).to eq('f')

      allow(player).to receive(:gets).and_return('u')
      player.get_move
      expect(player.last_move).to eq('u')

      allow(player).to receive(:gets).and_return('q')
      player.get_move
      expect(player.last_move).to eq('q')
    end

    it "does not modify @last_move if the move is invalid" do
      allow(player).to receive(:gets).and_return('a')
      player.get_move
      expect(player.last_move).not_to eq('a')

      allow(player).to receive(:gets).and_return('c')
      player.get_move
      expect(player.last_move).to eq('c')

      allow(player).to receive(:gets).and_return('z')
      player.get_move
      expect(player.last_move).not_to eq('z')
      expect(player.last_move).to eq('c')
    end
  end

  describe "#get_coords" do
    it "prints a message asking the player for the coordinates he wants to make a move at"

    it "accepts an input of 'x, y' as a valid coordinate, where 0 <= x <= rows - 1 and 0 <= y <= cols - 1"

    it "prints an error message for all other moves"

    it "sets @last_coords to valid coordinates"

    it "returns true for valid coordinates"

    it "returns false for invalid coordinates"
  end
end