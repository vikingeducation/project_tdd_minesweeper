require 'tile'

describe "Tile" do

  let(:tile){ Tile.new }

  describe "initialize tiles " do

    it "is unrevealed" do
      expect(tile.revealed?).to eq false
    end

  end

  describe '#reveal' do
    it 'reveals the tile if it is unrevealed' do
      tile.reveal
      expect(tile.revealed?).to eq true
    end
  end

end
