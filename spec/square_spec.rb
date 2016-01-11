require 'square'

describe Square do

  let(:mine_square) { Square.build_mine }
  let(:empty_square) { Square.build_empty }

  describe '.build_mine' do
    it 'builds a Square with a mine' do
      expect(mine_square.has_mine?).to eq(true)
    end
  end

  describe '.build_empty' do
    it 'builds a Square without mine' do
      expect(empty_square.has_mine?).to eq(false)
    end
  end

  describe '#proximity' do
    it 'a square\'s mine proximity count is readable' do
      expect(empty_square.proximity).to eq(0)
    end
  end

  describe '#proximity=()' do
    it 'raises ArgumentError if input is not a Fixnum' do
      expect{empty_square.proximity="hi"}.to raise_error(ArgumentError, "Not an integer!")
    end

    it 'raises ArgumentError if input is not between 1 and 8 inclusive' do
      expect{empty_square.proximity = 99}.to raise_error(ArgumentError, "Must be between 0-8")
    end

    it 'a square\'s proximity count can be set to an integer value' do
      adjacent_mines = 5
      empty_square.proximity = adjacent_mines
      expect(empty_square.proximity).to eq(adjacent_mines)
    end
  end

  describe '#cleared' do
    it 'a square\'s clear status is readable' do
      expect(empty_square.cleared).to eq(false)
    end
  end

  describe '#cleared=()' do
    it 'raises an error if argument is not boolean' do
      expect{empty_square.cleared = 10}.to raise_error(ArgumentError, "Not a Boolean!")
    end

    it 'a square\'s clear status can be set' do
      new_val = true
      empty_square.cleared = new_val
      expect(empty_square.cleared).to eq(new_val)
    end
  end
end
