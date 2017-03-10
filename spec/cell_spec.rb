# spec/cell_spec.rb

require 'cell'
include Minesweeper

describe "Cell" do
  let (:cell) { Cell.new }

  describe "#initialize" do
    it "creates a Cell" do
      expect(cell).to be_a(Cell)
    end

    it "sets the Cell's initial state to :uncleared" do
      expect(cell.state).to eq(:uncleared)
    end

    it "sets the Cell as not having a mine" do
      expect(cell.mine).to be false
    end

    it "sets the Cell's adjacent mine count to 0" do
      expect(cell.adjacent_mine_count).to eq(0)
    end
  end

  describe "#clear" do
    it "sets the Cell's state to :cleared" do
      cell.clear
      expect(cell.state).to eq(:cleared)
    end
  end

  describe "#flag" do
    it "sets the Cell's state to :flagged" do
      cell.flag
      expect(cell.state).to eq(:flagged)
    end

    it "does not allow a cleared cell to be flagged" do
      cell.clear
      cell.flag
      expect(cell.state).to eq(:cleared)
    end
  end

  describe "#unflag" do
    it "sets the Cell's state to :uncleared" do
      cell.flag
      cell.unflag
      expect(cell.state).to eq(:uncleared)
    end

    it "does not unflag a cleared cell" do
      cell.clear
      cell.unflag
      expect(cell.state).to eq(:cleared)
    end
  end

  context "whether a Cell has a mine" do
    it "can be set to true" do
      cell.mine = true
      expect(cell.mine).to be true
    end

    it "can be set to false" do
      cell.mine = false
      expect(cell.mine).to be false
    end

    it "cannot be set to any other value" do
      expect { cell.mine = "blah" }.to raise_error(/must be true or false/)
      expect { cell.mine = 42 }.to raise_error(/must be true or false/)
    end
  end

  context "number of adjacent mines for a Cell" do
    it "can be set to a value from 0 to 8" do
      cell.adjacent_mine_count = 0
      expect(cell.adjacent_mine_count).to eq(0)

      cell.adjacent_mine_count = 1
      expect(cell.adjacent_mine_count).to eq(1)

      cell.adjacent_mine_count = 2
      expect(cell.adjacent_mine_count).to eq(2)

      cell.adjacent_mine_count = 3
      expect(cell.adjacent_mine_count).to eq(3)

      cell.adjacent_mine_count = 4
      expect(cell.adjacent_mine_count).to eq(4)

      cell.adjacent_mine_count = 5
      expect(cell.adjacent_mine_count).to eq(5)

      cell.adjacent_mine_count = 6
      expect(cell.adjacent_mine_count).to eq(6)

      cell.adjacent_mine_count = 7
      expect(cell.adjacent_mine_count).to eq(7)

      cell.adjacent_mine_count = 8
      expect(cell.adjacent_mine_count).to eq(8)
    end

    it "cannot be set to any other value" do
      expect { cell.adjacent_mine_count = "one" }.to raise_error(/0 to 8/)
    end
  end

  context "implementing to_s" do
    context "Cell does not have a mine" do
      it "returns '.' if the Cell is uncleared" do
        expect(cell.to_s).to eq('.')
      end

      it "returns 'F' if the Cell is flagged" do
        cell.flag
        expect(cell.to_s).to eq('F')
      end

      it "returns '-' if a cleared Cell has no adjacent mines" do
        cell.clear
        expect(cell.to_s).to eq('-')
      end

      it "returns the adjacent mine count of a cleared Cell" do
        cell.clear
        cell.adjacent_mine_count = 8
        expect(cell.to_s).to eq('8')
      end
    end

    context "Cell has a mine" do
      it "returns '.' if the Cell is uncleared" do
        cell.mine = true
        expect(cell.to_s).to eq('.')
      end

      it "returns 'X' if the Cell is cleared" do
        cell.mine = true
        cell.clear
        expect(cell.to_s).to eq('X')
      end
    end
  end
end