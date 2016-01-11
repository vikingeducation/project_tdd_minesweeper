
require 'tile'

describe "Tile" do 
  
  let(:tile){ Tile.new }

  describe "initialize tiles " do

    it "is unrevealed" do
      expect(tile.revealed?).to eq(false)
    end
    
  end
end  