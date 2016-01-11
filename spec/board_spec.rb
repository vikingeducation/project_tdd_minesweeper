require 'board'

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

    it "places bombs" do
      
    end
  end
end