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

  describe "#state=" do
    it "can set the Cell's state to cleared'" do
      cell.state = :cleared
      expect(cell.state).to eq(:cleared)
    end

    it "can set the Cell's state to 'flagged'" do
      cell.state = :flagged
      expect(cell.state).to eq(:flagged)
    end

    it "can set the Cell's state to 'uncleared'" do
      cell.state = :cleared
      cell.state = :uncleared
      expect(cell.state).to eq(:uncleared)
    end

    it "cannot set the Cell's state to anything else" do
      expect { cell.state = "blah" }.to raise_error(/invalid state/)
      expect { cell.state = Hash.new }.to raise_error(/invalid state/)
    end
  end

  describe "has a mine" do
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

  describe "adjacent mine count" do
    it "can be set to a value from 1 to 8" do
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
      expect { cell.adjacent_mine_count = "one" }.to raise_error(/1 to 8/)
    end
  end
end