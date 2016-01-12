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

    it "it has a danger level of 0" do
      expect(tile.danger_level).to eq 0
    end
  end

  describe '#danger_level=' do
    it 'sets a danger level' do
      tile.danger_level = 4
      expect(tile.danger_level).to eq 4
    end
  end

  describe '#reveal!' do
    it 'reveals the tile if it is unrevealed' do
      tile.reveal!
      expect(tile.revealed?).to eq true
    end
  end

  describe '#mine!' do
    it 'sets the mine on the tile' do
      tile.mine!
      expect(tile.mine?).to eq true
    end
  end

  describe '#completely_safe?' do
    it 'returns true if the danger level is 0' do
      tile.danger_level = 0
      expect(tile.completely_safe?).to eq true
    end

    it 'returns false if the danger level greater than 0' do
      tile.danger_level = 3
      expect(tile.completely_safe?).to eq false
    end

    it 'returns false if the tile is mined' do
      tile.mine!
      expect(tile.completely_safe?).to eq false
    end
  end

  describe '#flag!' do
    it 'flags the tile if it not flagged' do
      tile.flag!
      expect(tile.flag?).to eq true
    end

    it 'unflags the tile if it is flagged' do
      flagged_tile = Tile.new(flag: true)
      flagged_tile.flag!
      expect(flagged_tile.flag?).to eq false
    end
  end
end
