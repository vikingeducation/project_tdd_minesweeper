RSpec.describe Minesweeper::Cell do
  before { Minesweeper::Cell.cells.clear }
  let(:cell) { Minesweeper::Cell.new(column: 1, row: 1) }

  describe '#initialize' do
    it 'sets a column and row' do
      cell = Minesweeper::Cell.new(column: 1, row: 1)
      expect(cell.column).to be 1
      expect(cell.row).to be 1
    end

    context 'arguments not given' do
      it 'raises an exeption' do
        expect { Minesweeper::Cell.new(row: 1)}.to raise_error(ArgumentError)
        expect { Minesweeper::Cell.new(column: 1)}.to raise_error(ArgumentError)
      end
    end

    it 'records the current cell' do
      expect(Minesweeper::Cell.cells).to include cell
    end
  end

  describe '.find' do
    it 'finds a cell based off its row and column' do
      expect(cell).to eq Minesweeper::Cell.find(row: 1, column: 1)
    end
  end

  describe '#place_mine' do
    it 'places a mine' do
      expect { cell.place_mine }.to change { cell.has_mine? }.from(false).to(true)
    end
  end

  describe '#has_mine?' do
    it 'defaults to false' do
      expect(cell.has_mine?).to be false
    end

    it 'returns true when it has a mine' do
      cell.place_mine
      expect(cell.has_mine?).to be true
    end
  end

  describe '#cleared?' do
    it 'defaults to false' do
      expect(cell.cleared?).to be false
    end

    it 'returns true if the cell is cleared' do
      cell.clear

      expect(cell.cleared?).to be true
    end
  end

  describe '#clear' do
    it 'clears the cell' do
      expect { cell.clear }.to change { cell.cleared? }.from(false).to(true)
    end
  end
  describe '#flaged?' do
    it 'defaults to false' do
      expect(cell.flaged?).to be false
    end

    it 'returns true if the cell is flaged' do
      cell.flag

      expect(cell.flaged?).to be true
    end
  end

  describe '#flag' do
    it 'clears the cell' do
      expect { cell.flag }.to change { cell.flaged? }.from(false).to(true)
    end
  end

  describe '#number_of_mines_around' do
    before do
      (1..10).each do |row|
        (1..10).each do |column|
          Minesweeper::Cell.new(row: row, column: column)
        end
      end
    end

    example 'with 0 mines around' do
      cell = Minesweeper::Cell.cells.first
      expect(cell.number_of_mines_around).to be_zero
    end

    example 'with 2 mines around' do
      cell = Minesweeper::Cell.find(row: 2, column: 4)
      Minesweeper::Cell.find(row: 1, column: 4).place_mine
      Minesweeper::Cell.find(row: 1, column: 3).place_mine
      expect(cell.number_of_mines_around).to be 2
    end
  end

  describe '#mines_around?' do
    context 'mines around' do
      it 'returns true' do
        allow(cell).to receive(:number_of_mines_around).and_return(5)
        expect(cell.mines_around?).to be true
      end
    end

    context 'no mines around' do
      it 'returns false' do
        allow(cell).to receive(:number_of_mines_around).and_return(0)
        expect(cell.mines_around?).to be false
      end
    end
  end
end
