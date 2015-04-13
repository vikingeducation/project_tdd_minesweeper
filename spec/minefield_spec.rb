require 'minefield'
require 'cell'

describe Minefield do

  let(:minefield) { Minefield.new(9, 9) }
  describe '#initialize' do
    it 'receives the width and height passed to it' do
      expect(minefield.width).to eq(9)
      expect(minefield.height).to eq(9)
    end
    it 'creates the initial game board' do
      expect(minefield.board).to_not be(nil)
    end
    it 'does not have any initially visible cells' do
      expect(minefield.board.flatten.count { |cell| cell.is_visible?}).to eq(0)
    end
    it 'does not place mines unless told to' do
      expect(minefield.board.flatten.count { |cell| cell.is_a_mine?}).to eq(0)
    end
  end

  describe '#place_mines' do
    it 'places passed number of mines on the game board' do
      minefield.place_mines(10)
      expect(minefield.board.flatten.count { |cell| cell.is_a_mine? }).to eq(10)
    end
  end

  describe '#place_mine_indicators' do
    it 'places the indicators on the board' do
      minefield.place_mines(20)
      minefield.place_mine_indicators
      expect(minefield.board.flatten.map { |cell| cell.value }).to include(1, 2, 3)
    end
    it 'does not place indicators if there are no mines' do
      minefield.place_mine_indicators
      expect(minefield.board.flatten.map { |cell| cell.value }).to_not include(1, 2, 3)
    end
  end
  describe '#make_move' do

    context 'when placing a flag' do
      it 'prompts for user input when they want to place a flag' do
        allow(minefield).to receive(:gets).and_return("1,2")
        expect(minefield).to receive(:gets)
        minefield.make_move(['F'])
      end
      # it 'tells user they have entered OOB coordinates for the flag' do
      #   allow(minefield).to receive(:gets).and_return("1,10")
      #   expect { minefield.make_move(['F']) }.to raise_error
      # end
    end

    context 'when making a move' do
      it 'calls autoclear if the move is not a mine' do
        expect(minefield).to receive(:autoclear)
        minefield.make_move([1, 2])
      end
      it 'exits the program when the move made is on a mine' do
        minefield.board[1][3].mine_henshin
        expect { minefield.make_move([1, 3]) }.to raise_error
      end
    end
  end
  describe '#won?' do
    it 'returns true when all non-mines are visibile' do
      minefield.board.flatten.each do |cell|
        if !cell.is_a_mine
          cell.toggle_visibility
        end
      end
      expect(minefield.won?).to be true
    end
  end
  describe '#in_bounds?' do
    it 'returns true when passed valid coordinates' do
      expect(minefield.in_bounds?(1, 8)).to be true
    end
    it 'returns false when passed OOB coordinates' do
      expect(minefield.in_bounds?(1, 9)).to be false
    end
  end

end