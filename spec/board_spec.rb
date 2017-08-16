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
  end

  describe '#flags_left' do
    it 'returns the number of flags left' do
      board = Minesweeper::Board.new(size: 20, mines: 12, cell: Minesweeper::Cell)

      board.flag(1, 1)
      expect(board.flags_left).to be 11
    end
  end
end
