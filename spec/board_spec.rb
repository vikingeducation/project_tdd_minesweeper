# spec/board_spec.rb

require 'board'
include Minesweeper

describe "Board" do
  let (:board) { Board.new }

  describe "#initialize" do
    it "creates a Board" do
      expect(board).to be_a(Board)
    end

    it "sets up a 10 x 10 grid with all elements set to nil" do
      expect(board.grid).to be_a(Array)
      expect(board.grid.size).to eq(10)
      expect(board.grid.all? { |row| row.size == 10 }).to be true
      expect(board.grid.all? { |row| row.all? { |cell| cell.nil? } }).to be true
    end

    # acceptance criteria states 9 mines, so we'll go with 9 flags for now
    it "sets the number of flags to 9" do
      expect(board.flags).to eq(9)
    end

    it "accepts an optional parameter to setup the game grid" do
      test_grid = [[1, 2, 3],
                  [4, 5, 6],
                  [7, 8, 9]]

      test_board = Board.new(test_grid)
      expect(test_board.grid).to eq(test_grid)
    end
  end

  describe "setup_minefield" do
    it "fills up the grid with Cells"

    it "randomly sets 9 Cells to have mines"
  end

  describe "valid_coordinate?" do
    it "returns true if the provided row and column are within range"

    it "returns false if the provided row and column are not within range"

    it "raises an error if the provided row and column inputs are not integers"
  end

  describe "num_adjacent_mines" do
    it "returns 0 if the number of adjacent mines for the Cell is 0"

    it "returns 1 if the number of adjacent mines for the Cell is 1"

    it "returns 2 if the number of adjacent mines for the Cell is 2"

    it "returns 3 if the number of adjacent mines for the Cell is 3"

    it "returns 4 if the number of adjacent mines for the Cell is 4"

    it "returns 5 if the number of adjacent mines for the Cell is 5"

    it "returns 6 if the number of adjacent mines for the Cell is 6"

    it "returns 7 if the number of adjacent mines for the Cell is 7"

    it "returns 8 if the number of adjacent mines for the Cell is 8"
  end

  describe "flags_left?" do
    it "returns true if the number of flags is greater than 0"

    it "returns false otherwise"
  end

  describe "decrement_flags" do
    it "decreases the number of flags remaining by 1"
  end

  describe "increment_flags" do
    it "increases the number of flags remaining by 1"
  end
end