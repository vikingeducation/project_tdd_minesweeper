require 'grid' 

describe Grid do


  let(:grid) { Grid.new }

  # TODO: think about switching to 3x3 or multiple let's
  let(:all_edges) do [
        [" ", " ", " ", " ", "*", " ", " ", " ", " "], 
        ["*", " ", " ", " ", "*", " ", " ", " ", " "], 
        [" ", "*", " ", " ", " ", " ", " ", " ", " "], 
        ["*", " ", " ", " ", " ", " ", " ", " ", "*"], 
        [" ", " ", " ", " ", " ", " ", " ", " ", "*"], 
        [" ", " ", " ", " ", "*", " ", " ", " ", " "], 
        [" ", " ", " ", " ", " ", "*", " ", " ", " "], 
        [" ", " ", " ", " ", " ", " ", " ", " ", " "], 
        [" ", " ", " ", "*", " ", " ", " ", " ", " "]
      ] 
  end


  describe "#initialize" do
    it "creates an empty grid of 9 columns and rows" do
      expect(grid.grid.length).to eq(9)  #rows
      expect(grid.grid[1].length).to eq(9)
    end
  end


  describe "#build_mines_hash" do
    it "creates hash of 10 bombs to place" do
      grid.build_mines_hash
      expect(grid.mines_hash.length).to eq(10)
    end
  end

 describe "#calculate_adjacent_bombs_for_square" do
    it "returns correct number of bombs" do
      grid.import_grid(all_edges)
      # middle
      expect(grid.calculate_adjacent_bombs_for_square(6, 4)).to eq(2)
      # left edge 
      expect(grid.calculate_adjacent_bombs_for_square(0, 0)).to eq(1)
      # right edge 
      expect(grid.calculate_adjacent_bombs_for_square(3, 8)).to eq(1)
      # top edge
      expect(grid.calculate_adjacent_bombs_for_square(0, 4)).to eq(1)
      # bottom edge
      expect(grid.calculate_adjacent_bombs_for_square(8, 2)).to eq(1)
    end
  end

  describe '#calculate_adjacent_flags' do
    it "returns correct number of flags" do
      expect(grid.calculate_adjacent_flags(4,3)).to eq(0)
      grid.place_flag(3,4)
      grid.place_flag(4,4)
      grid.place_flag(5,3)
      expect(grid.calculate_adjacent_flags(4,3)).to eq(3)
    end

  end

  describe '#place_flag' do
    it "switches flagged=false to flagged=true" do
      expect(grid.grid[5][6].flagged).to be false
      grid.place_flag(5,6)
      expect(grid.grid[5][6].flagged).to be true
    end
  end


  describe '#neighbors' do
    it 'returns array of coordinates of neighboring squares' do
      neighbors_arr = grid.neighbors(1,5)
      expect(neighbors_arr.length).to eq(8)
    end
  end

end