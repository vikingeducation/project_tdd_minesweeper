require 'board'
require 'tile'

describe Board do
  let( :minesweeper ){ Board.new }
  describe "#initialize" do
    it "creates a new board" do
      expect(minesweeper).to be_an_instance_of(Board)
    end

    it "board instance variable should be an array" do
      expect(minesweeper.board).to be_an_instance_of(Array)
    end

    it "new board should have 10 rows and 10 columns" do
      expect(minesweeper.board.size).to eq(10)
    end
  end

  describe "#mine_coords" do 
    it "returns 10 coordinates" do
      minesweeper.mine_coords(10)
      expect(minesweeper.mines.count).to eq(10)
    end
  end

  describe "#neighbors" do
    it "should return list of neighboring tiles" do
      array1 = [[4, 4], [5, 4], [6, 4], [4, 5], [6, 5], [4, 6], [5, 6], [6, 6]]
      array2 = minesweeper.neighbors([5,5])
      expect(array2.sort).to eq(array1.sort)
    end

    it "should only keep coordinates in bounds" do
      array1 = [[0, 1], [1, 0], [1, 1]]
      array2 = minesweeper.neighbors([0, 0])
      expect(array2.sort).to eq(array1.sort)
    end
  end

  describe "#check_for_mines" do
    it "should return 0 if there are no neighboring mines" do
      expect(minesweeper.check_for_mines([5,5])).to eq(0)
    end

    it "should return number of neighboring mines" do
      minesweeper.board[5][4].make_mine
      expect(minesweeper.check_for_mines([5,5])).to eq(1)
    end
  end

  describe "#toggle_flag" do
    it "should toggle flag" do
      minesweeper.toggle_flag([5,5])
      expect(minesweeper.board[5][5].is_flagged).to eq(true)
    end
  end

  describe "#reveal_tile" do
    it "should reveal tile" do
      minesweeper.reveal_tile([5,5])
      expect(minesweeper.board[5][5].is_revealed).to eq(true)
    end
  end
end