require 'grid' 

describe Grid do

  context "starting game with empty grid" do

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

        it "creates an empty grid" do
          expect(grid.grid.length).to eq(9)  #rows
          expect(grid.grid[1].length).to eq(9)
        end

      end


      describe "#place_bombs" do

        it "places 10 bombs" do
          grid.build_mines_hash
          grid.place_bombs
          expect(grid.mines_hash.length).to eq(10)
        end

      end

     describe "#calculate_adjacent_bombs" do

        it "returns correct number of bombs" do
          grid.import_grid(all_edges)
          # middle
          expect(grid.calculate_adjacent_bombs(6, 4)).to eq(2)
          # left edge 
          expect(grid.calculate_adjacent_bombs(0, 0)).to eq(1)
          # right edge 
          expect(grid.calculate_adjacent_bombs(3, 8)).to eq(1)
          # top edge
          expect(grid.calculate_adjacent_bombs(0, 4)).to eq(1)
          # bottom edge
          expect(grid.calculate_adjacent_bombs(8, 2)).to eq(1)
        end
      end

      describe '#place_flag' do
        it "switches flagged=false to flagged=true" do
          expect(grid.grid[5][6].flagged).to be false
          grid.place_flag(5,6)
          expect(grid.grid[5][6].flagged).to be true
        end
      end

  end

end