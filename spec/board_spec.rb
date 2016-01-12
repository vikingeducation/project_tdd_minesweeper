require 'board'
require 'tile'

describe 'Board' do

  let(:small_board) { Board.new(size: 3) }

  describe '#initialize' do

    context 'with no parameters' do

      let(:default_board) { Board.new }

      it 'has a size of 10' do
        expect(default_board.size).to eq 10
      end

      it 'has 9 mines' do
        expect(default_board.mines).to eq 9
      end

      it 'creates a 2-D array of tiles' do
        expect(default_board.grid[0][0]).to be_a Tile
      end

    end

    context 'with custom parameters' do

      let(:custom_board) { Board.new(size: 100) }

      it 'has a size of 100' do
        expect(custom_board.size).to eq 100
      end

      it 'has 99 mines' do
        expect(custom_board.mines).to eq 99
      end

    end

  end

  describe  "#populate_the_mines" do
    it "places 2 mines on an empty board" do
      small_board.populate_mines([0,0])
      expect(small_board.placed_mine_count).to eq(2)
    end

    it "places no mines on the starting coordinate" do
      30.times do
        small_board.populate_mines([2,2])
        expect(small_board.grid[2][2].mine?).to eq(false)
      end
    end
  end

  describe '#reveal_coord' do

    context 'coord is flagged' do

      it 'coord is unchanged' do
        tile = small_board.tile_at([1,1])
        tile.flag!
        small_board.reveal_coord([1,1])
        expect(tile.revealed?).to eq false
      end

    end

    context 'coord is dangerous' do

      it 'reveals the coordinate' do
        tile = small_board.tile_at([1,0]).mine!

        small_board.reveal_coord([1,1])
        tile = small_board.tile_at([1,1])
        expect(tile.revealed?).to eq true
      end

    end

    context 'coord is completely_safe' do

      let(:safe_grid) do
        [
          [ "*", "_", "_"],
          [ "*", "_", "_"],
          [ "_", "_", "_"],
        ]
      end

      let(:expected_out) do
        [
          [ "_", "2", "0"],
          [ "_", "2", "0"],
          [ "_", "1", "0"],
        ]

      end

      it 'reveals coords outwardly, stopping once they are dangerous' do
        small_board.load_grid(safe_grid)
        small_board.reveal_coord([2,2])
        expect(small_board.compare_grid(expected_out)).to eq true
      end

    end

    context 'coord is a mine'

  end

  describe "#set_danger_levels" do
    it 'assigns danger levels for the board' do
      danger_grid = [
        [ "*", "*", "_"],
        [ "*", "_", "_"],
        [ "_", "_", "_"],
      ]
      small_board.load_grid(danger_grid)
      tile = small_board.tile_at([1,1])
      tile2 = small_board.tile_at([2,1])

      small_board.set_danger_levels
      expect(tile.danger_level).to eq 3
      expect(tile2.danger_level).to eq 1
    end
  end

  describe '#valid_coord' do
    it 'returns true if the coord is on the board' do
      expect(small_board.valid_coord([1,1])).to eq true
    end

    it 'returns false if the coord is off of the board' do
      expect(small_board.valid_coord([2,8])).to eq false
    end

    it 'returns false if the coord is off of the board' do
      expect(small_board.valid_coord([3,0])).to eq false
    end
  end

  describe "compare 2 grids"  do
    let(:expected_out) do
      [
        [ "_", "_", "_"],
        [ "_", "_", "1"],
        [ "_", "_", "0"],
      ]
    end

    it "compares a grid to the expected grid" do
        tile = small_board.tile_at([2,2])
        tile2 = small_board.tile_at([1,2])
        tile.reveal!
        tile2.reveal!
        tile2.danger_level = 1
        expect(small_board.compare_grid(expected_out)).to eq(true)
    end


  end
end
