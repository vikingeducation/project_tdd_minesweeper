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
      test_grid = [[1, 2, 3],
                  [4, 5, 6],
                  [7, 8, 9]]

      test_board = Board.new(test_grid)
      expect(test_board.grid).to eq(test_grid)
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
    it "returns true if the provided row and column are within range" do
      expect(board.valid_coordinate?(0, 0)).to be true
      expect(board.valid_coordinate?(9, 9)).to be true
    end

    it "returns false if the provided row and column are not within range" do
      expect(board.valid_coordinate?(-1, -1)).to be false
      expect(board.valid_coordinate?(10, 10)).to be false
    end

    it "raises an error if the provided row and column inputs are not integers" do
      expect { board.valid_coordinate?("1", "2") }.to raise_error(/must be integers/)

      expect { board.valid_coordinate?(Hash.new, Array.new) }.to raise_error(/must be integers/)
    end
  end

  describe "#adjacent_mines" do
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