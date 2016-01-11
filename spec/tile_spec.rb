require 'tile'

describe "Tile" do

  let(:tile){ Tile.new }

  context "when initialzed with no parameters" do

    it "is unrevealed" do
      expect(tile.revealed?).to eq false
    end

    it "is not mined" do
      expect(tile.mine?).to eq false
    end

    it "is not flagged" do
      expect(tile.flag?).to eq false
    end


  end

  describe '#reveal' do
    it 'reveals the tile if it is unrevealed' do
      tile.reveal
      expect(tile.revealed?).to eq true
    end

  end

  describe '#mine' do
    it 'sets the mine on the tile' do
      tile.mine
      expect(tile.mine?).to eq true
    end

  end

  describe '#flag' do
    it 'flags the tile if it not flagged' do
      tile.flag
      expect(tile.flag?).to eq true
    end

    it 'unflags the tile if it is flagged' do
      flagged_tile = Tile.new(flag: true)
      flagged_tile.flag
      expect(flagged_tile.flag?).to eq false
    end
  end
end
