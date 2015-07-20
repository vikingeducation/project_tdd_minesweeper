require 'board'

describe Board do

  let(:test_cell) { instance_double("Cell", :mined? => false ) }
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

      it "sets range based on the max number of rows in the grid" do
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

  end



  context "playing game" do

    describe "#make_move(coords, action)" do
      it "flags the specified cell and returns true" do
        expect( test_board ).to receive(:flag_cell)
        expect( test_board.make_move( [0,0], :flag ) ).to be true        
      end

      it "reveals cell, starts auto_reveal_search, and returns true" do
        expect( test_cell ).to receive(:reveal!).and_return(true)
        expect( test_cell ).to receive(:flagged?).and_return(false)
        expect( test_board ).to receive(:auto_reveal_search)
        expect( test_board.make_move( [0,0], :reveal ) ).to be true
      end

      it "does not call flag_cell and returns nil if the coords aren't on the grid" do
        expect( test_board ).not_to receive(:flag_cell)
        expect( test_board.make_move( [10,10], :flag ) ).to be nil
      end

      it "does not cell auto_reveal_search and returns nil if the coords aren't on the grid" do
        expect( test_board ).not_to receive(:auto_reveal_search)
        expect( test_board.make_move( [10,10], :reveal ) ).to be nil        
      end
    end

    describe "#flag_cell(coords)" do
      it "sets a cell to flagged" do
        c = Cell.new
        b = Board.new( {0 => [c]} )
        b.flag_cell( [0, 0] )
        expect( c.flagged? ).to be true
      end

      it "removes flag from already flagged cell" do
        c = Cell.new
        b = Board.new( {0 => [c]} )
        allow( b ).to receive(:puts)
        b.flag_cell( [0, 0] )
        b.flag_cell( [0, 0] )
        expect( c.flagged? ).to be false
      end
    end

    describe "#reveal_mine?" do
      let(:game_over) { instance_double("Cell", :mined? => true, :covered? => false) }
      let(:game_over_board) { Board.new( { 0 => [game_over] } ) }

      it "returns true if any mined cell has been revealed" do
        expect( game_over_board.revealed_mine? ).to be true
      end

      it "returns false if the cell isn't mined" do
        board = Board.new
        expect( board.revealed_mine? ).to be false
      end
    end

    describe "victory?" do
      it "returns true if all mines are flagged" do
        flagged_mine = Cell.new
        flagged_mine.mine!
        flagged_mine.flag!
        board = Board.new( {0 => [flagged_mine, flagged_mine],
                            1 => [flagged_mine, flagged_mine] } )
        expect( board.victory? ).to be true        
      end

      it "returns false if all mines are not flagged" do
        flagged_mine = Cell.new
        mine = Cell.new
        mine.mine!
        flagged_mine.mine!
        flagged_mine.flag!
        board = Board.new( {0 => [mine, flagged_mine],
                            1 => [flagged_mine, flagged_mine] } )
        expect( board.victory? ).to be false  
      end
    end

  end



end