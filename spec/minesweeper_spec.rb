require 'minesweeper'
require 'board'
require 'player'

describe Minesweeper do
	let(:game) { Minesweeper.new }
	describe "#initialize" do
		it "initializes with board" do
      expect(game.board).to be_an_instance_of(Board)
    end

    it "initializes with player" do
      expect(game.player).to be_an_instance_of(Player)
    end
	end

  describe "#make_move" do
    it "allows a square to be flagged" do
      game.make_move([5,5], "flag")
      expect(game.board.board[5][5].is_flagged).to eq(true)
    end
  end

  describe "#place_mines" do
    it "places 10 bombs" do
      game.board.mine_coords(10)
      game.place_mines(game.board.mines)
      expect(game.board.mines.length).to eq(10)
    end
  end
end

    