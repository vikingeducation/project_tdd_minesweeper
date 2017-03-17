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
    it "sets the number of flags to 9 by default" do
      expect(board.flags).to eq(9)
    end

    it "accepts an optional parameter to setup the game grid" do
      test_grid = Array.new(3) { Array.new(3) { Cell.new } }
      test_board = Board.new(test_grid)

      expect(test_board.grid).to eq(test_grid)
      expect(test_board.grid.all? { |row| row.all? { |cell| cell.is_a?(Cell) } }).to be true
    end

    it "accepts an optional parameter for the number of mines" do
      num_mines = 1
      test_grid = Array.new(3) { Array.new(3) { Cell.new } }
      test_board = Board.new(test_grid, num_mines)

      expect(test_board.mines).to eq(1)
    end

    it "sets the board to have the same number of flags as mines" do
      num_mines = 1
      test_grid = Array.new(3) { Array.new(3) { Cell.new } }
      test_board = Board.new(test_grid, num_mines)

      expect(test_board.flags).to eq(1)
    end
  end

  describe "#setup_minefield" do
    it "randomly sets 9 cells in the grid to be mines, if the number of mines is not specified" do
      board.setup_minefield

      mine_count = 0
      board.grid.each do |row|
        row.each do |cell|
          mine_count += 1 if cell.mine
        end
      end

      expect(mine_count).to eq(9)
    end

    it "randomly sets the specified number of cells in the grid to be mines" do
      num_mines = 3
      test_grid = Array.new(3) { Array.new(3) { Cell.new } }
      test_board = Board.new(test_grid, num_mines)
      test_board.setup_minefield

      mine_count = 0
      test_board.grid.each do |row|
        row.each do |cell|
          mine_count += 1 if cell.mine
        end
      end

      expect(mine_count).to eq(3)
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

  describe "#cell_flagged?" do
    it "returns true if the cell at the provided row/column is flagged" do
      board.grid[0][0].flag
      expect(board.cell_flagged?(0, 0)).to be true
    end

    it "returns false otherwise" do
      expect(board.cell_flagged?(0, 0)).to be false
    end
  end

  describe "#cell_has_mine?" do
    it "returns true if the cell at the provided row/col has a mine" do
      board.grid[9][9].mine = true
      expect(board.cell_has_mine?(9, 9)).to be true
    end

    it "returns false otherwise" do
      expect(board.cell_has_mine?(9, 9)).to be false
    end
  end

  describe "#clear" do
    it "marks a cell at the provided row/column as cleared" do
      board.clear(0, 0)
      expect(board.cell_cleared?(0, 0)).to be true
    end

    it "updates the adjacent mine count of the cleared cell" do
      board.grid[0][1].mine = true
      board.grid[1][0].mine = true
      board.grid[1][1].mine = true
      board.clear(0, 0)

      expect(board.grid[0][0].adjacent_mine_count).to eq(3)
    end

    it "does not clear a flagged cell" do
      board.flag(0, 0)
      board.clear(0, 0)
      expect(board.cell_flagged?(0, 0)).to be true
      expect(board.cell_cleared?(0, 0)).to be false
    end

    context "cleared cell has no adjacent mines" do
      it "auto-clears the cell's adjacent cells"

      it "if any of those adjacent cells have no adjacent mines, their adjacent cells are auto-cleared too"
    end
  end

  describe "#flag" do
    before(:each) do
      allow(board).to receive(:puts).and_return(nil)
    end

    it "marks an uncleared cell at the provided row/column as flagged" do
      board.flag(0, 0)
      expect(board.cell_flagged?(0, 0)).to be true
    end

    it "does not flag a cleared cell" do
      board.clear(0, 0)
      board.flag(0, 0)
      expect(board.cell_cleared?(0, 0)).to be true
      expect(board.cell_flagged?(0, 0)).to be false
    end

    it "does not change the state of a flagged cell" do
      board.flag(0, 0)
      board.flag(0, 0)
      expect(board.cell_flagged?(0, 0)).to be true
    end

    it "does not flag a cell if there are no flags left" do
      num_mines = 1
      test_grid = Array.new(3) { Array.new(3) { Cell.new } }
      test_board = Board.new(test_grid, num_mines)
      expect(test_board.flags).to eq(1)

      test_board.flag(0, 0)
      expect(test_board.flags).to eq(0)
      expect(test_board.cell_flagged?(0, 0)).to be true

      test_board.flag(0, 1)
      expect(test_board.flags).to eq(0)
      expect(test_board.cell_flagged?(0, 1)).to be false
    end

    it "decreases the number of flags left by 1" do
      flags = board.flags
      board.flag(0, 0)
      expect(board.flags).to eq(flags - 1)
    end
  end

  describe "#unflag" do
    before(:each) do
      allow(board).to receive(:puts).and_return(nil)
    end

    it "marks a flagged cell at the provided row/column as uncleared" do
      board.flag(0, 0)
      board.unflag(0, 0)
      expect(board.cell_flagged?(0, 0)).to be false
      expect(board.cell_cleared?(0, 0)).to be false
    end

    it "does not change the state of a cleared cell" do
      board.clear(0, 0)
      board.unflag(0, 0)
      expect(board.cell_cleared?(0, 0)).to be true
    end

    it "does not change the state of an uncleared cell" do
      board.unflag(0, 0)
      expect(board.cell_cleared?(0, 0)).to be false
    end

    it "increases the number of flags left by 1" do
      flags = board.flags
      board.flag(0, 0)
      board.unflag(0, 0)
      expect(board.flags).to eq(flags)
    end
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
    let(:test_grid) { Array.new(10) { Array.new(10) { Cell.new } } }
    let(:test_board) { Board.new(test_grid) }

    it "returns 0 if the number of adjacent mines for the Cell is 0" do
      expect(test_board.adjacent_mines(0, 0)).to eq(0)
    end

    it "returns 1 if the number of adjacent mines for the Cell is 1" do
      test_board.grid[0][1].mine = true
      expect(test_board.adjacent_mines(0, 0)).to eq(1)
    end

    it "returns 2 if the number of adjacent mines for the Cell is 2" do
      test_board.grid[0][1].mine = true
      test_board.grid[1][0].mine = true
      expect(test_board.adjacent_mines(0, 0)).to eq(2)
    end

    it "returns 3 if the number of adjacent mines for the Cell is 3" do
      test_board.grid[0][1].mine = true
      test_board.grid[1][0].mine = true
      test_board.grid[1][1].mine = true
      expect(test_board.adjacent_mines(0, 0)).to eq(3)
    end

    it "returns 4 if the number of adjacent mines for the Cell is 4" do
      test_board.grid[9][4].mine = true
      test_board.grid[9][6].mine = true
      test_board.grid[8][4].mine = true
      test_board.grid[8][5].mine = true
      expect(test_board.adjacent_mines(9, 5)).to eq(4)
    end

    it "returns 5 if the number of adjacent mines for the Cell is 5" do
      test_board.grid[9][4].mine = true
      test_board.grid[9][6].mine = true
      test_board.grid[8][4].mine = true
      test_board.grid[8][5].mine = true
      test_board.grid[8][6].mine = true
      expect(test_board.adjacent_mines(9, 5)).to eq(5)
    end

    it "returns 6 if the number of adjacent mines for the Cell is 6" do
      test_board.grid[4][4].mine = true
      test_board.grid[4][5].mine = true
      test_board.grid[4][6].mine = true
      test_board.grid[5][4].mine = true
      test_board.grid[5][6].mine = true
      test_board.grid[6][4].mine = true
      expect(test_board.adjacent_mines(5, 5)).to eq(6)
    end

    it "returns 7 if the number of adjacent mines for the Cell is 7" do
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

  describe "#all_safe_cells_cleared?" do
    let(:test_grid) { Array.new(3) { Array.new(3) { Cell.new } } }
    let(:test_board) { Board.new(test_grid) }

    it "returns true if all safe cells (those without mines) are cleared" do
      (0...test_board.rows).each do |row|
        (0...test_board.cols).each do |col|
          test_board.clear(row, col)
        end
      end

      expect(test_board.all_safe_cells_cleared?).to be true
    end

    it "returns false if not all safe cells are cleared" do
      test_board.clear(0, 0)
      expect(test_board.all_safe_cells_cleared?).to be false
    end

    it "returns false if a cell with a mine is cleared" do
      test_board.grid[2][2].mine = true

      (0...test_board.rows).each do |row|
        (0...test_board.cols).each do |col|
          test_board.clear(row, col)
        end
      end

      expect(test_board.all_safe_cells_cleared?).to be false
    end
  end
end