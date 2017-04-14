require 'minesweeper'

describe Minesweeper do
  let(:ms) { Minesweeper.new }

  describe ' #initialize ' do
    it ' creates a board of the default size (10) ' do
      board = ms.instance_variable_get(:@board)
      expect(board.size).to eq(10)
      expect(board[0].length).to eq(10)
      expect(board[board.size - 1].length).to eq(10)
    end

    it ' creates a custom board size ' do
      rows = 5
      columns = 20
      ms2 = Minesweeper.new(rows, columns)
      board = ms2.instance_variable_get(:@board)
      expect(board.size).to eq(rows)
      expect(board[0].length).to eq(columns)
      expect(board[board.size - 1].length).to eq(columns)
    end

    it ' adds 25% of board size bombs to the board ' do
      board = ms.instance_variable_get(:@board)
      bomb_count = 0
      board.length.times do |row_iter|
        board[0].length.times do |col_iter|
          board[row_iter][col_iter].bomb ? bomb_count += 1 : next
        end
      end
      expect(bomb_count).to eq(board.length * board[0].length * 0.25)
    end

  end

  describe ' #render ' do
    it ' prints the board ' do
      expect(ms).to receive(:render)
      ms.render
    end
  end
end
