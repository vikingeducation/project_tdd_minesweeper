require 'tile'

describe Tile do
  let(:tile) { Tile.new }

  describe '#initialize' do
    it 'starts as safe' do
      expect(tile).to be_safe
    end

    it 'starts as unflagged' do
      expect(tile).to_not be_flagged
    end

    it 'starts as unrevealed' do
      expect(tile).to_not be_revealed
    end
  end

  describe '#mine!' do
    it 'makes the tile unsafe' do
      tile.mine!
      expect(tile).to_not be_safe
    end
  end

  describe '#flag!' do
    it 'makes the tile flagged' do
      tile.flag!
      expect(tile).to be_flagged
    end
  end

  describe '#reveal!' do
    it 'makes the tile revealed' do
      tile.reveal!
      expect(tile).to be_revealed
    end
  end
end
