require 'board'

describe Board do

  let(:test_cell) { instance_double("Cell", :mined? => false) }
  let(:mined_cell) { instance_double("Cell", :mined? => true) }
  let(:test_grid) { {0 => [test_cell, mined_cell, test_cell, test_cell],
                     1 => [test_cell, test_cell, test_cell, test_cell],
                     2 => [test_cell, test_cell, test_cell, mined_cell],
                     3 => [test_cell, test_cell, test_cell, test_cell]} }
  let(:test_board) { Board.new(test_grid) }

  context "play grid setup" do

    describe "#initialize" do
      
      it "allows the grid to be set when created" do
        b = Board.new(test_grid)
        expect( b.grid ).to eq(test_grid)
      end

      it "#blank_grid creates a 10x10 grid of cells" do
        # playing around with doubles, all this not really nessisary
        expect( Cell ).to receive(:new).exactly(100).times { "fake_cell" }
        Board.new
        # expect( b.grid[9,9] ).to eq("fake_cell")
        # expect( b.grid[9,10] ).to be nil
      end

      it "sets range to the max number of rows in the grid" do
        expect( test_board.range ).to eq(0..3)
      end

    end

    describe "#place_mines" do
      
      it "randomly mines 9 cells" do
        expect( Cell ).to receive(:new).exactly(100).times { test_cell }
        expect( test_cell ).to receive(:mine!).exactly(9).times 
        b = Board.new
        b.place_mines
      end

      it "should not call mine! on a cell that's already mined" do
        expect( Cell ).to receive(:new).exactly(100).times { mined_cell }
        expect( mined_cell ).not_to receive(:mine!)
        b = Board.new
        b.place_mines
      end

    end

  end

  context "helper methods" do
    describe "#cell(coords)" do
      it "fetches the specified cell from the grid" do
        expect( test_board.cell( [0,0] ) ).to eq( test_cell )
      end

      it "returns nil if the specified cell doesn't exist" do
        expect( test_board.cell( [0,-1] ) ).to be nil
      end
      
    end
    
  end

  context "playing game" do

    describe "#get_neighbors(row, col)" do
      it "returns coordinates of all adjacent cells" do
        expect( test_board.get_neighbors( [2,1] ) ).to eq(
          [ [1, 0], [1, 1], [1, 2], [2, 0], [2, 2], [3, 0], [3, 1], [3, 2] ] )
      end

      it "all coordinates should be unique" do
        # testing this because we found bug in code
        neighbors = test_board.get_neighbors( [2,1] )
        expect( neighbors.uniq ).to eq(neighbors)
      end

      it "should only return coordinates that are within the grid" do
        expect( test_board.get_neighbors( [2,0] ) ).to eq(
          [ [1, 0], [1, 1], [2, 1], [3, 0], [3, 1] ])
      end
      
    end

    describe "#flag_cell(coords)" do
      it "sets a cell to flagged and returns true" do
        b = Board.new( {0 => [Cell.new]} )
        expect( b.flag_cell( [0, 0] ) ).to be true
      end

      it "returns false if the cell is already flagged" do
        c = Cell.new
        c.flag!
        b = Board.new( {0 => [c]} )
        allow( b ).to receive(:puts)
        expect( b.flag_cell( [0, 0] ) ).to be false
      end
    end

    describe "#count_mined_neighbors(row, col)" do
      it "sets the count of adajecent cells that are mined" do
        expect( test_cell ).to receive(:mined_neighbors=) {1}
        test_board.count_mined_neighbors( [0,0] )
      end

      it "sets 0 if no adajecent cells are mined" do
        expect( test_cell ).to receive(:mined_neighbors=) {0}
        test_board.count_mined_neighbors( [2,1] )        
      end
    end

    describe "#auto_reveal_cell?(coords)" do


      it "returns false if the cell is revealed" do
        allow( test_cell ).to receive_messages(:covered? => false)
        expect( test_board.auto_reveal_cell?( [2,1] ) ).to eq(false)
      end

      it "returns false if the cell is mined" do
        allow( test_cell ).to receive_messages(:covered? => true,
                                               :mined? => true)
        expect( test_board.auto_reveal_cell?( [2,1] ) ).to eq(false)        
      end

      it "returns false if the cell is flagged" do
        allow( test_cell ).to receive_messages(:covered? => true,
                                               :mined? => false,
                                               :flagged? => true)
        expect( test_board.auto_reveal_cell?( [2,1] ) ).to eq(false)
      end

      it "returns true if the cell is covered, isn't mined, and isn't flagged" do
        allow( test_cell ).to receive_messages(:covered? => true,
                                               :mined? => false,
                                               :flagged? => false)        
        expect( test_board.auto_reveal_cell?( [2,1] ) ).to eq(true)
      end
      
    end
    
  end

  context "clearing cells recursively" do
    let(:cell_a) { Cell.new }
    let(:cell_b) { Cell.new }
    let(:cell_c) { Cell.new }
    let(:cell_d) { Cell.new }
    let(:cell_e) { Cell.new }
    let(:cell_f) { Cell.new }
    let(:cell_g) { Cell.new }
    let(:cell_h) { Cell.new }
    let(:cell_z) { Cell.new }
    let(:test_grid) { {0 => [cell_a, cell_b, cell_c, cell_d],
                       1 => [cell_e, cell_f, cell_g, cell_h],
                       2 => [cell_h, cell_h, cell_h, cell_h],
                       3 => [cell_h, cell_h, cell_h, cell_z]} }
    let(:test_board) { Board.new(test_grid) }
    
    describe "#auto_reveal_cells(cells)" do
      it "reveals cells automatically if they aren't mines, flagged, or already uncovered" do
        cells = [ [0,0], [0,1] ]
        expect( cell_a ).to receive(:reveal!)
        expect( cell_b ).to receive(:reveal!)
        test_board.reveal_cells(cells)
      end
    end
  end

end