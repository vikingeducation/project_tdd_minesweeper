RSpec.describe Minesweeper::Board do

  let(:board) { Minesweeper::Board.new }

  describe '#initialize' do
    it 'defaults to a size of 10, 9 mines, and a cell class' do
      expect(board.size).to be 10
      expect(board.mines).to be 9
      expect(board.instance_variable_get(:@cell)).to be Minesweeper::Cell
    end

    it 'sets to size of 20, 12 mines and array class' do
      board = Minesweeper::Board.new(size: 20, mines: 12, cell: Array)
      expect(board.size).to be 20
      expect(board.mines).to be 12
      expect(board.instance_variable_get(:@cell)).to be Array
    end
  end

  describe '#data' do
    let(:cell) {  Minesweeper::Cell }
    let(:board) { Minesweeper::Board.new(size: 20, mines: 12, cell: cell) }
    it 'returns 2D array equals to size' do
      expect(board.data).to be_an Array
      expect(board.data.size).to eq board.size
    end

    specify 'each row is equals to board size' do
      expect(board.data).to all be_an Array
      board.data.each { |row| expect(row.size).to eq board.size }
    end

    specify 'cells are instences of the cell class given' do
      expect(board.data.flatten).to all be_a cell
    end

    specify 'each cell knows its row and column index' do
      board.data.each_with_index do |row, row_index|
        row.each_with_index do |cell, col_index|
          expect(cell.row).to eq row_index
          expect(cell.column).to eq col_index
        end
      end
    end

    it 'has the number of mines specified' do
      cells_with_mines = board.data.flatten.select(&:has_mine?)
      expect(cells_with_mines.size).to eq board.mines
    end
  end

  describe '#flag' do
    it 'flags the specified cell' do
      board.flag(1, 1)
      expect(board.data[1][1]).to be_flaged
    end
  end

  describe '#clear' do
    it 'clears the specified cell' do
      board.clear(2, 3)
      expect(board.data[2][3]).to be_cleared
    end

    it 'auto clears cells' do
      data = (0..3).map do |row_index|
               (0..3).map do |cell_index|
                  Minesweeper::Cell.new(row: row_index, column: cell_index)
                end
              end
              
      allow(board).to receive(:data).and_return(data)
      board.clear(1, 1)
      expect(board.all_cleared?).to be true
    end
  end

  describe '#flags_remaining' do
    it 'returns the number of flags left' do
      board = Minesweeper::Board.new(size: 20, mines: 12, cell: Minesweeper::Cell)

      board.flag(1, 1)
      expect(board.flags_remaining).to be 11
    end
  end

  describe '#cleared_mine?' do
    context 'player cleared a cell containing a mine' do
      it 'returns true' do
        cell_with_mine = board.data.flatten.detect { |col| col.has_mine? }
        board.clear(cell_with_mine.row, cell_with_mine.column)

        expect(board.cleared_mine?).to be true
      end
    end

    context 'player cleared a cell not containing a mine' do
      it 'returns false' do
        cell_with_mine = board.data.flatten.detect { |col| !col.has_mine? }
        board.clear(cell_with_mine.row, cell_with_mine.column)

        expect(board.cleared_mine?).to be false
      end
    end
  end

  describe 'all_cleared?' do
    context 'all cells are cleared are have flags' do
      it 'returns true' do
        board.data.flatten.each do |cell|
          cell.has_mine? ? cell.flag : cell.clear
        end

        expect(board.all_cleared?).to eq true
      end
    end

    context 'not all cells are cleared are have flags' do
      it 'returns false' do
        expect(board.all_cleared?).to eq false
      end
    end
  end

  describe '#valid_move?' do
    let(:board) { Minesweeper::Board.new(size: 10) }

    it 'returns false if out of range row' do
      expect(board.valid_move?(10, 3)).to be false
    end

    it 'returns false if out of range column' do
      expect(board.valid_move?(9, 10)).to be false
    end

    it 'returns false if cell has been cleared' do
      board.clear(9, 9)
      expect(board.valid_move?(9, 9)).to be false
    end

    it 'returns false if cell has been flaged' do
      board.flag(9, 9)
      expect(board.valid_move?(9, 9)).to be false
    end

    it 'returns true when in range' do
      expect(board.valid_move?(3, 3)).to be true
    end

    it 'returns true if cell has not been cleared' do
      expect(board.valid_move?(9, 9)).to be true
    end

    it 'returns true if cell has not been flaged' do
      expect(board.valid_move?(9, 9)).to be true
    end
  end
end
