require 'grid'

describe Grid do

  context "starting game with empty grid" do

    let(:grid) { Grid.new }

      describe "#initialize" do

        it "creates an empty grid" do
          expect(grid.grid.length).to eq(9)  #rows
          expect(grid.grid[1].length).to eq(9)
        end

      end


      describe "#place_bombs" do

        it "places 10 bombs" do
          hash = grid.place_bombs
          expect(hash.length).to eq(10)
        end

      end

  end

end