require 'minesweeper'
require 'board'

describe "Minesweeper" do

  describe "#Initialize" do
    let(:game){Minesweeper.new}
    it 'should create Board object' do

      expect(game.board.class).to be(Board)
    end

    it "breakes the loop when got request from user" do
      allow(game).to receive(:gets).and_return("Q")
      expect(game.board).not_to receive(:clear)
      game.game
    end

    it "plays a move" do
      allow(game).to receive(:gets).and_return("1 1", "Q")
      expect(game.board).to receive(:clear)
      game.game
     #How to make a test just one time
    end

    it "should ask for a correct coordinates" do
      allow(game).to receive(:gets).and_return("12 15", "Q")
      expect(game.board).not_to receive(:clear)
      game.game
    end

  end


end

