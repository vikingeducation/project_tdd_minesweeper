require 'minesweeper'

describe Minesweeper do
  # let(:test_cell) { instance_double("Cell", :mined? => false) }
  # let(:mined_cell) { instance_double("Cell", :mined? => true) }
  # let(:test_grid) { {0 => [test_cell, mined_cell, test_cell, test_cell],
  #                    1 => [test_cell, test_cell, test_cell, test_cell],
  #                    2 => [test_cell, test_cell, test_cell, mined_cell],
  #                    3 => [test_cell, test_cell, test_cell, test_cell]} }
  # let(:test_board) { Board.new(test_grid) }
  # let(:test_sweeper) { Minesweeper.new(test_board) }
  let(:fake_board) { instance_double("Board", :place_mines => nil, 
                      :set_mined_neighbors_for_all_cells => nil) }
  let(:fake_player) { instance_double("Player", :get_coords => [0,0] ) }



  describe "#initialize" do
    it "creates a new board" do
      expect( Board ).to receive(:new).and_return( fake_board )
      Minesweeper.new
    end

    it "calls #place_mines on the board" do
      expect( Board ).to receive(:new).and_return( fake_board )
      expect( fake_board ).to receive(:place_mines)
      Minesweeper.new
    end

    it "calls #set_mined_neighbors_for_all_cells on the board" do
      expect( Board ).to receive(:new).and_return( fake_board )
      expect( fake_board ).to receive(:set_mined_neighbors_for_all_cells)
      Minesweeper.new
    end
  end


  describe "#game_loop" do
    it "asks the player for input" do
      # expect( fake_player).to receive(:get_coords)
      # subject.game_loop
    end
  end


  
end