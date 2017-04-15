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

    it ' adds 9 mines to the board by default ' do
      board = ms.instance_variable_get(:@board)
      bomb_count = 0
      board.length.times do |row_iter|
        board[0].length.times do |col_iter|
          board[row_iter][col_iter].bomb ? bomb_count += 1 : next
        end
      end
      expect(bomb_count).to eq(9)
    end

  end

  describe ' #render ' do
    it ' prints the board ' do
      expect(ms).to receive(:render)
      ms.render
    end

    it ' prints an uncovered board ' do
      ms.uncover_board
      ms.render
    end

    it ' prints the instructions ' do
      ms.print_instructions
    end
  end

  describe ' #game_over? ' do
    it ' returns true if all empty cells are uncovered ' do
      ms.uncover_board
      expect(ms.game_over?).to eq(true)
    end
  end

  describe ' #turn ' do
    it ' accepts user input and returns false when out of bounds ' do
      allow(ms).to receive(:gets).and_return('12,2,F')
      expect(ms.turn).to eq(false)
    end

    it ' accepts user input and returns false when not a valid command ' do
      allow(ms).to receive(:gets).and_return('7,2,Q')
      expect(ms.turn).to eq(false)
    end

    it ' accepts user input and returns true when a valid command ' do
      allow(ms).to receive(:gets).and_return('2,2,F')
      expect(ms.turn).to_not eq(false)
    end
  end

end
