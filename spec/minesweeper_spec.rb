require 'minesweeper'

describe Minesweeper do
  let(:game) { Minesweeper.setup_game }

  describe '.setup_game' do

    it 'intializes a board instance variable set to nil' do
      expect(game.instance_variable_get(:@board)).to eq(nil)
    end

    it 'initializes a move counter initially set to 0' do
      expect(game.instance_variable_get(:@move_counter)).to eq(0)
    end
  end
end
