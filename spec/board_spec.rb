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

    it "places 10 bombs" do
      count = 0
      minesweeper.board.each do |row|
        count += row.count("X")
      end
      expect(count).to eq 10
    end
  end

  describe "#place_mines" do
    it "places 10 mines into the board" do
      expect(minesweeper.place_mines(10)).to eq true
    end

    it "places 1000 mines into the board" do
      expect(minesweeper.place_mines(1000)).to eq false
    end
  end
end