# spec/player_spec.rb

require 'board'
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

    it "sets @last_move to nil if the move is invalid" do
      allow(player).to receive(:gets).and_return('c')
      player.get_move
      expect(player.last_move).to eq('c')

      allow(player).to receive(:gets).and_return('z')
      player.get_move
      expect(player.last_move).to be_nil
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

    it "sets @last_coords to nil otherwise" do
      allow(player).to receive(:gets).and_return("12")
      player.get_coords
      expect(player.last_coords).to be_nil

      allow(player).to receive(:gets).and_return("1, 2")
      player.get_coords
      expect(player.last_coords).to eq([1, 2])

      allow(player).to receive(:gets).and_return("blah, 1   5")
      player.get_coords
      expect(player.last_coords).to be_nil
    end
  end

  describe "#make_move" do
    let (:test_grid) { Array.new(3) { Array.new(3) { Cell.new } } }
    let (:test_board) { Board.new(test_grid) }

    before(:each) do
      allow(player).to receive(:print).and_return(nil)
      allow(player).to receive(:puts).and_return(nil)
    end

    it "it clears the cell at the coordinate the user has specified" do
      allow(player).to receive(:gets).and_return('c', '0, 0')
      player.get_move
      player.get_coords
      player.make_move(test_board)
      expect(test_board.cell_cleared?(0, 0)).to be true
    end

    it "flags the cell at the coordinate the user has specified" do
      allow(player).to receive(:gets).and_return('f', '1, 1')
      player.get_move
      player.get_coords
      player.make_move(test_board)
      expect(test_board.cell_flagged?(1, 1)).to be true
    end

    it "unflags the cell at the coordinate the user has specified" do
      allow(player).to receive(:gets).and_return('f', '2, 2', 'u', '2, 2')
      
      player.get_move
      player.get_coords
      player.make_move(test_board)

      player.get_move
      player.get_coords
      player.make_move(test_board)

      expect(test_board.cell_flagged?(2, 2)).to be false
    end

    it "returns false if @last_move is nil (indicating an invalid action)" do
      allow(player).to receive(:gets).and_return('a', '0, 0')
      player.get_move
      player.get_coords

      expect(player.last_move).to be_nil
      expect(player.make_move(test_board)).to be false
    end

    it "returns false if @last_coords is nil (indicating a wrongly-formatted coordinate)" do
      allow(player).to receive(:gets).and_return('c', 'blah, 1   5')
      player.get_move
      player.get_coords

      expect(player.last_coords).to be_nil
      expect(player.make_move(test_board)).to be false
    end

    it "returns false if @last_coords is an out-of-range coordinate" do
      allow(player).to receive(:gets).and_return('c', '10, 10')
      player.get_move
      player.get_coords

      expect(player.make_move(test_board)).to be false
    end
  end
end