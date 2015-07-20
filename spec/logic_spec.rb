require 'board'
require 'logic'

describe Logic do

  let(:test_cell) { instance_double("Cell", :mined? => false) }
  let(:mined_cell) { instance_double("Cell", :mined? => true) }
  let(:test_grid) { {0 => [test_cell, mined_cell, test_cell, test_cell],
                     1 => [test_cell, test_cell, test_cell, test_cell],
                     2 => [test_cell, test_cell, test_cell, mined_cell],
                     3 => [test_cell, test_cell, test_cell, test_cell]} }
  let(:test_board) { Board.new(test_grid) }


  
  context "helper methods" do

    describe "#cell(coords)" do
      it "fetches the specified cell from the grid" do
        expect( test_board.cell( [0,0] ) ).to eq( test_cell )
      end

      it "returns nil if the specified cell doesn't exist" do
        expect( test_board.cell( [0,-1] ) ).to be nil
      end
    end
    
    describe "#get_neighbors(coords)" do
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

  end

  

  context "revealing cells recursively" do

    let(:cell_a) { Cell.new }
    let(:cell_b) { Cell.new }
    let(:cell_c) { Cell.new }
    let(:cell_d) { Cell.new }
    let(:cell_e) { Cell.new }
    let(:cell_f) { Cell.new }
    let(:cell_g) { Cell.new }
    let(:cell_h) { Cell.new }
    let(:cell_z) { instance_double("Cell") }
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
        test_board.auto_reveal_cells(cells)
      end
    end

    describe "#auto_reveal?(coords)" do
      it "returns false if the cell is revealed" do
        allow( cell_z ).to receive_messages(:covered? => false)
        expect( test_board.auto_reveal?( [3,3] ) ).to eq(false)
      end

      it "returns false if the cell is mined" do
        allow( cell_z ).to receive_messages(:covered? => true,
                                            :mined? => true)
        expect( test_board.auto_reveal?( [3,3] ) ).to eq(false)        
      end

      it "returns false if the cell is flagged" do
        allow( cell_z ).to receive_messages(:covered? => true,
                                            :mined? => false,
                                            :flagged? => true)
        expect( test_board.auto_reveal?( [3,3] ) ).to eq(false)
      end

      it "returns true if the cell is covered, isn't mined, and isn't flagged" do
        allow( cell_z ).to receive_messages(:covered? => true,
                                            :mined? => false,
                                            :flagged? => false)        
        expect( test_board.auto_reveal?( [3,3] ) ).to eq(true)
      end
    end

    describe "#add_to_queue?(coords)" do
      it "returns false if the cell cannot be auto revealed" do
        allow( test_board ).to receive(:auto_reveal?).with( [3,3] ) { false }
        expect( test_board.add_to_queue?( [3,3] ) ).to be false
      end

      it "returns false if the cell has mined neighbors" do
        allow( test_board ).to receive(:auto_reveal?).with( [3,3] ) { true }
        allow( cell_z ).to receive(:mined_neighbors) { 1 }
        expect( test_board.add_to_queue?( [3,3] ) ).to be false
      end

      it "returns true if the cell can be auto revealed and does not have mined neighbors" do
        expect( test_board.add_to_queue?( [0,0] )).to be true
      end
    end

    describe "#queue_cells_for_search(cells)" do
      it "returns cells that should be added to the auto_reveal_search" do
        allow( test_board ).to receive(:add_to_queue?).with( [0,0] ) { true }
        allow( test_board ).to receive(:add_to_queue?).with( [0,1] ) { false }
        allow( test_board ).to receive(:add_to_queue?).with( [0,2] ) { true }
        cells = [[0,0],[0,1],[0,2]]
        expect( test_board.queue_cells_for_search( cells ) ).to match_array([[0,0],[0,2]])
      end
    end

    describe "#auto_reveal_search(coords)" do
      it "performs a recursive search for cells that can be automatically revealed" do
        board = Board.new
        board.cell([0,0]).mine!
        board.cell([0,9]).mine!
        board.cell([9,0]).mine!
        board.cell([9,9]).mine!
        board.set_mined_neighbors_for_all_cells

        covered = board.grid.values.flatten.count { |cell| cell.covered? }
        expect( covered ).to eq(100)

        board.auto_reveal_search([1,1])
        covered = board.grid.values.flatten.count { |cell| cell.covered? }
        expect( covered ).to eq(4)
      end
    end

  end

end