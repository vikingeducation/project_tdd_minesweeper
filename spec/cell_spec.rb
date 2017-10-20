require 'cell'

describe Cell do 

  let (:cell) { Cell.new }

  describe "#initialize" do 
    it "initializes a new Cell" do 
      expect(cell).to be_a(Cell)
    end

    specify "new cells do no contain mines" do 
      expect(cell.mine).to be false
    end

    specify "new cells are not flagged" do 
      expect(cell.flag).to be false
    end

    specify "new cells are not cleared" do 
      expect(cell.clear).to be false
    end
  end

  describe "#set_mine" do 
    it "changes cell.mine from false to true" do 
      cell.set_mine
      expect(cell.mine).to be true
    end
  end

  describe "#set_flag" do 
    it "changes cell.flag from false to true" do 
      cell.set_flag
      expect(cell.flag).to be true
    end
  end

  describe "#clear_cell" do 
    it "changes cell.clear from false to true" do 
      cell.clear_cell
      expect(cell.clear).to be true
    end
  end
end