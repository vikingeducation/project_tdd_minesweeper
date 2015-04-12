require 'minefield'

describe Minefield do

  let(:minefield) { Minefield.new(9, 9) }
  describe '#initialize' do
    it 'receives the width and height passed to it' do
      expect(minefield.width).to eq(9)
      expect(minefield.height).to eq(9)
    end
    it 'creates the initial game board' do
      expect(minefield.board).to eq([[0, 0, 0, 0, 0, 0, 0, 0, 0],
                                    [0, 0, 0, 0, 0, 0, 0, 0, 0],
                                    [0, 0, 0, 0, 0, 0, 0, 0, 0],
                                    [0, 0, 0, 0, 0, 0, 0, 0, 0],
                                    [0, 0, 0, 0, 0, 0, 0, 0, 0],
                                    [0, 0, 0, 0, 0, 0, 0, 0, 0],
                                    [0, 0, 0, 0, 0, 0, 0, 0, 0],
                                    [0, 0, 0, 0, 0, 0, 0, 0, 0],
                                    [0, 0, 0, 0, 0, 0, 0, 0, 0]])
    end
  end

  describe '#place_mines' do
    it 'places passed number of mines on the game board' do
      minefield.place_mines(10)
      expect(minefield.board.flatten.count(4)).to eq(10)
    end
  end
  describe '#place_mine_indicators' do
    it 'places the indicators on the board' do
      minefield.place_mines(20)
      minefield.place_mine_indicators
      expect(minefield.board.flatten).to include(1, 2, 3)
    end
    it 'does not place indicators if there are no mines' do
      minefield.place_mine_indicators
      expect(minefield.board.flatten).to_not include(1, 2, 3)
    end
  end

end