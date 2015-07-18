require 'board'

describe Board do

  context "play grid setup" do

    describe "#initialize" do
      
      it "allows the grid to be set when created" do
        test_grid = [0, 0, 0] 
        b = Board.new(test_grid)
        expect( b.grid ).to eq(test_grid)
      end

      it "#blank_grid creates a 10x10 grid of cells" do
        # playing around with doubles, all this not really nessisary
        expect( Cell ).to receive(:new).exactly(100).times { "fake_cell" }
        b = Board.new
        expect( b.grid[9][9] ).to eq("fake_cell")
        expect( b.grid[9][10] ).to be nil
      end

    end

    describe "#place_mines" do
      
      it "randomly mines 9 cells" do
        cell = instance_double("Cell", :mined? => false)
        expect( Cell ).to receive(:new).exactly(100).times { cell }
        expect( cell ).to receive(:mine!).exactly(9).times 
        b = Board.new
        b.place_mines
      end

      it "should not call mine! on a cell that's already mined" do
        cell = instance_double("Cell", :mined? => true)
        expect( Cell ).to receive(:new).exactly(100).times { cell }
        expect( cell ).not_to receive(:mine!)
        b = Board.new
        b.place_mines
      end

    end

  end

  context "playing game" do

    describe "#flag_cell(coords)" do

      it "sets a cell to flagged and returns true" do
        b = Board.new( {0 => [Cell.new]} )
        expect( b.flag_cell(0, 0) ).to be true
      end

      it "returns false if the cell is already flagged" do
        c = Cell.new
        c.flag!
        b = Board.new( {0 => [c]} )
        allow( b ).to receive(:puts)
        expect( b.flag_cell(0, 0) ).to be false
      end
      
    end

    describe "#count_mined_neighbors(row, col)" do
      let(:cell) { instance_double("Cell", :mined? => false) }
      let(:mined_cell) { instance_double("Cell", :mined? => true) }
      let(:test_grid) { {0 => [cell, mined_cell, cell, cell],
                         1 => [cell, cell, cell, cell],
                         2 => [cell, cell, cell, mined_cell],
                         3 => [cell, cell, cell, cell]} }

      it "returns the count of adajecent cells that are mined" do
        b = Board.new(test_grid)
        expect( b.count_mined_neighbors(0,0) ).to eq(1)
      end

      it "returns 0 if no adajecent cells are mined" do
        b = Board.new(test_grid)
        expect( b.count_mined_neighbors(2,1) ).to eq(0)        
      end
      
    end
    
  end

end