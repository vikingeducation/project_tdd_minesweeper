require 'grid' 

describe Grid do

  context "starting game with empty grid" do

    let(:grid) { Grid.new }

    let(:all_edges) do [
          [" ", " ", " ", " ", "*", " ", " ", " ", " "], 
          ["*", " ", " ", " ", "*", " ", " ", " ", " "], 
          ["", "*", " ", " ", " ", " ", " ", " ", " "], 
          ["*", " ", " ", " ", " ", " ", " ", " ", "*"], 
          [" ", " ", " ", " ", " ", " ", " ", " ", "*"], 
          [" ", " ", " ", " ", "*", "", " ", " ", " "], 
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

        it "" do

          grid.import_grid(all_edges)
          expect(grid.calculate_adjacent_bombs(6, 4)).to eq(2)
          expect(grid.calculate_adjacent_bombs(0, 0)).to eq(1quit)
        end

      end

  end

end