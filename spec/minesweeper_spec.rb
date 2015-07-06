require 'minesweeper'
require 'board'

describe "Minesweeper" do

  describe "#Initialize" do
    let(:game){Minesweeper.new}
    it 'should create Board object' do

      expect(game.board.class).to be(Board)
    end

    


  end


end

