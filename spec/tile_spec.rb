require 'tile'

describe Tile do

  context "#initialize" do

    let(:tile) { Tile.new(1,2) }

    it "makes a new tile" do
      expect(tile).to be_a(Tile)
    end

    it "initially is not a mine" do
      expect(tile.mine).to be(false)
    end

    it "initially has 0 neighboring_mines" do
      expect(tile.neighboring_mines).to eq(0)
    end

    it "initially is a hidden tile" do
      expect(tile.hidden).to be(true)
    end

    it "initally does not have a flag" do
      expect(tile.flag).to be(false)
    end

  end

end
