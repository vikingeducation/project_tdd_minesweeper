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
    before(:each) do
      allow(player).to receive(:print).and_return(nil)
      allow(player).to receive(:puts).and_return(nil)
    end

    it "returns true if the input has two elements, separated by a comma/variable whitespace" do
      allow(player).to receive(:gets).and_return("1, 2")
      expect(player.get_coords).to be true

      allow(player).to receive(:gets).and_return("3  ,    4")
      expect(player.get_coords).to be true
    end

    it "returns false otherwise" do
      allow(player).to receive(:gets).and_return("12")
      expect(player.get_coords).to be false

      allow(player).to receive(:gets).and_return("blah, 1   5")
      expect(player.get_coords).to be false
    end

    it "sets @last_coords to an array of two integers if the input has two elements, separated by a comma/variable whitespace" do
      allow(player).to receive(:gets).and_return("1, 2")
      player.get_coords
      expect(player.last_coords).to eq([1, 2])

      allow(player).to receive(:gets).and_return("3  ,    4")
      player.get_coords
      expect(player.last_coords).to eq([3, 4])      
    end

    it "does not modify @last_coords otherwise" do
      allow(player).to receive(:gets).and_return("12")
      player.get_coords
      expect(player.last_coords).to be_nil

      allow(player).to receive(:gets).and_return("1, 2")
      player.get_coords
      expect(player.last_coords).to eq([1, 2])

      allow(player).to receive(:gets).and_return("blah, 1   5")
      player.get_coords
      expect(player.last_coords).to eq([1, 2])
    end
  end

  describe "#make_move" do
    it "if the player has specified a valid coordinate to clear, it clears that cell"

    it "if the player has specified a valid coordinate to flag, it flags that cell"

    it "if the player has specified a valid coordinate to unflag, it unflags that cell"
  end
end