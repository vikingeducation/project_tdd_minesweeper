require 'minefield'

describe Minefield do

  let(:m){ Minefield.new }
  let(:size25){ Minefield.new(25) }

  describe '#new' do
    describe 'takes a field size argument' do
      it 'defaults to a 10 by 10 field' do
        expect(m.size).to eq 10
      end
      it 'can take an integer as the size' do
        size12 = Minefield.new(12)
        expect(size12.size).to eq 12
      end
      it 'raises error if the argument is not an integer' do
        expect do
          Minefield.new("intermediate")
        end.to raise_error
      end
    end

    describe 'adds a certain number of mines' do
      it 'adds 9 mines to the default field' do
        expect(m.number_of_mines).to be 9
      end
      it 'adds 100 mines to a 25x25 field' do
        expect(size25.number_of_mines).to be 100
      end
    end

    describe 'verifies that the number of mines is correct' do
      it 'counts 9 mines on the default field' do
        placed_mines = m.field.flatten.count { |cell| cell.mine }
        expect(placed_mines).to be 9
      end
      it 'counts 100 mines on a 25x25 field' do
        placed_mines = size25.field.flatten.count { |cell| cell.mine }
        expect(placed_mines).to be 100
      end
    end

    describe 'counts adjacent mines for every cell' do
      it ''
    end
  end

  describe '#field' do
    it 'is an array' do
      expect(m.field).to be_a_kind_of Array
    end
    it 'has as many rows as the field size' do
      expect(m.field.length).to eq m.size
    end
    it 'each row is as long as the field size' do
      expect(m.field.all? { |row| row.length == m.size }).to be true
    end
    it 'has a cell object in every cell' do
      expect(m.field.flatten.all? { |cell| cell.class == Cell }).to be true
    end
    it 'cells have unique object IDs' do
      expect(m.field[0][0]).not_to equal m.field[5][5]
      expect(m.field[0][9]).not_to equal m.field[9][0]
      expect(m.field[3][7]).not_to equal m.field[7][3]
    end
  end

  describe '#winning?' do
    # let(:cleared_field) do
    #   cleared_field = Minefield.new
    #   cleared_field.field.flatten.each do |cell|
    #     cell.clear
    #   end
    #   cleared_field
    # end
    # it 'true when every cell is cleared' do
    #   expect(cleared_field.winning?).to be true
    # end
    # it 'is false when any cell has exploded' do
    #   cleared_field.field[4][4].place_mine
    #   expect(cleared_field.winning?).to be false
    # end
    # it 'true when every cell is flagged'
  end
end