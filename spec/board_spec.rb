# spec/board_spec.rb

require 'board'
include Minesweeper

describe "Board" do
  let (:board) { Board.new }

  describe "#initialize" do
    it "creates a Board" do
      expect(board).to be_a(Board)
    end

    it "sets up a 10 x 10 grid with all elements set to an instance of Cell" do
      expect(board.grid).to be_a(Array)
      expect(board.grid.size).to eq(10)
      expect(board.grid.all? { |row| row.size == 10 }).to be true
      expect(board.grid.all? { |row| row.all? { |cell| cell.is_a?(Cell) } }).to be true
    end

    # acceptance criteria states 9 mines, so we'll go with 9 flags for now
    it "sets the number of flags to 9" do
      expect(board.flags).to eq(9)
    end

    it "accepts an optional parameter to setup the game grid" do
      test_grid = Array.new(3) { Array.new(3) { Cell.new } }
      test_board = Board.new(test_grid)

      expect(test_board.grid).to eq(test_grid)
      expect(test_board.grid.all? { |row| row.all? { |cell| cell.is_a?(Cell) } }).to be true
    end
  end

  describe "#setup_minefield" do
    it "randomly sets 9 Cells in the grid to be mines" do
      board.setup_minefield

      mine_count = 0
      board.grid.each do |row|
        row.each do |cell|
          mine_count += 1 if cell.mine
        end
      end

      expect(mine_count).to eq(9)
    end
  end

  describe "#valid_coordinate?" do
    let (:rows) { 10 }
    let (:cols) { 10 }

    it "returns true if the provided row and column are within range" do
      expect(board.valid_coordinate?(0, 0)).to be true
      expect(board.valid_coordinate?(rows - 1, cols - 1)).to be true
    end

    it "returns false if the provided row and column are not within range" do
      expect(board.valid_coordinate?(-1, -1)).to be false
      expect(board.valid_coordinate?(rows, cols)).to be false
    end

    it "raises an error if the provided row and column inputs are not integers" do
      expect { board.valid_coordinate?("1", "2") }.to raise_error(/must be integers/)

      expect { board.valid_coordinate?(Hash.new, Array.new) }.to raise_error(/must be integers/)
    end
  end

  describe "#cell_cleared?" do
    it "returns true if the cell at the provided row/column is cleared" do
      board.grid[0][0].clear
      expect(board.cell_cleared?(0, 0)).to be true
    end

    it "returns false otherwise" do
      expect(board.cell_cleared?(0, 0)).to be false
    end
  end

  describe "#clear" do
    it "marks a cell at the provided row/column as cleared"
  end

  describe "#flag" do
    it "marks a cell at the provided row/column as flagged"

    it "does not change a cleared cell"
  end

  describe "#unflag" do
    it "marks a flagged cell at the provided row/column as uncleared"

    it "does not change a cleared cell"
  end

  describe "#adjacent_cells" do
    it "given the row/col of a corner cell, returns its adjacent cells" do
      num = 3
      # top left corner
      cells = board.adjacent_cells(0, 0)
      expect(cells.size).to eq(num)
      expect(cells).to include(board.grid[0][1])
      expect(cells).to include(board.grid[1][0])
      expect(cells).to include(board.grid[1][1])

      # top right corner
      cells = board.adjacent_cells(0, 9)
      expect(cells.size).to eq(num)
      expect(cells).to include(board.grid[0][8])
      expect(cells).to include(board.grid[1][9])
      expect(cells).to include(board.grid[1][8])

      # bottom left corner
      cells = board.adjacent_cells(9, 0)
      expect(cells.size).to eq(num)
      expect(cells).to include(board.grid[8][0])
      expect(cells).to include(board.grid[9][1])
      expect(cells).to include(board.grid[8][1])

      # bottom right corner
      cells = board.adjacent_cells(9, 9)
      expect(cells.size).to eq(num)
      expect(cells).to include(board.grid[8][9])
      expect(cells).to include(board.grid[9][8])
      expect(cells).to include(board.grid[8][8])
    end

    it "given the row/col of a cell along an edge, returns its adjacent cells as an array" do
      # top edge
      cells = board.adjacent_cells(0, 5)
      expect(cells.size).to eq(5)
      expect(cells).to include(board.grid[0][4])
      expect(cells).to include(board.grid[0][6])
      expect(cells).to include(board.grid[1][5])
      expect(cells).to include(board.grid[1][4])
      expect(cells).to include(board.grid[1][6])

      # left edge
      cells = board.adjacent_cells(5, 0)
      expect(cells.size).to eq(5)
      expect(cells).to include(board.grid[4][0])
      expect(cells).to include(board.grid[6][0])
      expect(cells).to include(board.grid[5][1])
      expect(cells).to include(board.grid[4][1])
      expect(cells).to include(board.grid[6][1])

      # right edge
      cells = board.adjacent_cells(5, 9)
      expect(cells.size).to eq(5)
      expect(cells).to include(board.grid[4][9])
      expect(cells).to include(board.grid[6][9])
      expect(cells).to include(board.grid[5][8])
      expect(cells).to include(board.grid[4][8])
      expect(cells).to include(board.grid[6][8])

      # bottom edge
      cells = board.adjacent_cells(9, 5)
      expect(cells.size).to eq(5)
      expect(cells).to include(board.grid[9][4])
      expect(cells).to include(board.grid[9][6])
      expect(cells).to include(board.grid[8][5])
      expect(cells).to include(board.grid[8][4])
      expect(cells).to include(board.grid[8][6])
    end

    it "given the row/col of a cell in the middle of the grid, returns its adjacent cells" do
      cells = board.adjacent_cells(5, 5)
      expect(cells.size).to eq(8)
      expect(cells).to include(board.grid[4][4])
      expect(cells).to include(board.grid[4][5])
      expect(cells).to include(board.grid[4][6])
      expect(cells).to include(board.grid[5][4])
      expect(cells).to include(board.grid[5][6])
      expect(cells).to include(board.grid[6][4])
      expect(cells).to include(board.grid[6][5])
      expect(cells).to include(board.grid[6][6])
    end
  end

  describe "#adjacent_mines" do
    # create an empty grid for testing - we can set mines as required
    let (:test_grid) { Array.new(10) { Array.new(10) { Cell.new } } }

    it "returns 0 if the number of adjacent mines for the Cell is 0" do
      test_board = Board.new(test_grid)
      expect(test_board.adjacent_mines(0, 0)).to eq(0)
    end

    it "returns 1 if the number of adjacent mines for the Cell is 1" do
      test_board = Board.new(test_grid)
      test_board.grid[0][1].mine = true
      expect(test_board.adjacent_mines(0, 0)).to eq(1)
    end

    it "returns 2 if the number of adjacent mines for the Cell is 2" do
      test_board = Board.new(test_grid)
      test_board.grid[0][1].mine = true
      test_board.grid[1][0].mine = true
      expect(test_board.adjacent_mines(0, 0)).to eq(2)
    end

    it "returns 3 if the number of adjacent mines for the Cell is 3" do
      test_board = Board.new(test_grid)
      test_board.grid[0][1].mine = true
      test_board.grid[1][0].mine = true
      test_board.grid[1][1].mine = true
      expect(test_board.adjacent_mines(0, 0)).to eq(3)
    end

    it "returns 4 if the number of adjacent mines for the Cell is 4" do
      test_board = Board.new(test_grid)
      test_board.grid[9][4].mine = true
      test_board.grid[9][6].mine = true
      test_board.grid[8][4].mine = true
      test_board.grid[8][5].mine = true
      expect(test_board.adjacent_mines(9, 5)).to eq(4)
    end

    it "returns 5 if the number of adjacent mines for the Cell is 5" do
      test_board = Board.new(test_grid)
      test_board.grid[9][4].mine = true
      test_board.grid[9][6].mine = true
      test_board.grid[8][4].mine = true
      test_board.grid[8][5].mine = true
      test_board.grid[8][6].mine = true
      expect(test_board.adjacent_mines(9, 5)).to eq(5)
    end

    it "returns 6 if the number of adjacent mines for the Cell is 6" do
      test_board = Board.new(test_grid)
      test_board.grid[4][4].mine = true
      test_board.grid[4][5].mine = true
      test_board.grid[4][6].mine = true
      test_board.grid[5][4].mine = true
      test_board.grid[5][6].mine = true
      test_board.grid[6][4].mine = true
      expect(test_board.adjacent_mines(5, 5)).to eq(6)
    end

    it "returns 7 if the number of adjacent mines for the Cell is 7" do
      test_board = Board.new(test_grid)
      test_board.grid[4][4].mine = true
      test_board.grid[4][5].mine = true
      test_board.grid[4][6].mine = true
      test_board.grid[5][4].mine = true
      test_board.grid[5][6].mine = true
      test_board.grid[6][4].mine = true
      test_board.grid[6][5].mine = true
      expect(test_board.adjacent_mines(5, 5)).to eq(7)
    end

    it "returns 8 if the number of adjacent mines for the Cell is 8" do
      test_board = Board.new(test_grid)
      test_board.grid[4][4].mine = true
      test_board.grid[4][5].mine = true
      test_board.grid[4][6].mine = true
      test_board.grid[5][4].mine = true
      test_board.grid[5][6].mine = true
      test_board.grid[6][4].mine = true
      test_board.grid[6][5].mine = true
      test_board.grid[6][6].mine = true
      expect(test_board.adjacent_mines(5, 5)).to eq(8)
    end
  end

  describe "#flags_left?" do
    it "returns true if the number of flags is greater than 0" do
      expect(board.flags_left?).to be true
    end

    it "returns false otherwise" do
      allow(board).to receive(:flags).and_return(0)
      expect(board.flags_left?).to be false
    end
  end

  describe "#decrement_flags" do
    it "decreases the number of flags remaining by 1" do
      board.decrement_flags
      expect(board.flags).to eq(8)
    end
  end

  describe "#increment_flags" do
    it "increases the number of flags remaining by 1" do
      board.increment_flags
      expect(board.flags).to eq(10)
    end
  end
end