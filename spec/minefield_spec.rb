require 'minefield'
require 'toy_minefield'

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
      let(:t){ ToyMinefield.new }
      it 'correctly labels neighbors of a single mine' do
        t.field[0][0].place_mine
        t.generate_adjacent_mine_counts
        expect(t.field[0][0].adjacent_mines).to be 0
        expect(t.field[0][1].adjacent_mines).to be 1
        expect(t.field[0][2].adjacent_mines).to be 0
        expect(t.field[1][0].adjacent_mines).to be 1
        expect(t.field[1][1].adjacent_mines).to be 1
        expect(t.field[1][2].adjacent_mines).to be 0
        expect(t.field[2][0].adjacent_mines).to be 0
        expect(t.field[2][1].adjacent_mines).to be 0
        expect(t.field[2][2].adjacent_mines).to be 0
      end
      it 'correctly labels neighbors of two mines' do
        t.field[0][0].place_mine
        t.field[0][2].place_mine
        t.generate_adjacent_mine_counts
        expect(t.field[0][0].adjacent_mines).to be 0
        expect(t.field[0][1].adjacent_mines).to be 2
        expect(t.field[0][2].adjacent_mines).to be 0
        expect(t.field[1][0].adjacent_mines).to be 1
        expect(t.field[1][1].adjacent_mines).to be 2
        expect(t.field[1][2].adjacent_mines).to be 1
        expect(t.field[2][0].adjacent_mines).to be 0
        expect(t.field[2][1].adjacent_mines).to be 0
        expect(t.field[2][2].adjacent_mines).to be 0
      end
      it 'correctly labels neighbors of multiple mines' do
        t.field[0][0].place_mine
        t.field[0][2].place_mine
        t.field[1][0].place_mine
        t.field[2][0].place_mine
        t.generate_adjacent_mine_counts
        expect(t.field[0][0].adjacent_mines).to be 1
        expect(t.field[0][1].adjacent_mines).to be 3
        expect(t.field[0][2].adjacent_mines).to be 0
        expect(t.field[1][0].adjacent_mines).to be 2
        expect(t.field[1][1].adjacent_mines).to be 4
        expect(t.field[1][2].adjacent_mines).to be 1
        expect(t.field[2][0].adjacent_mines).to be 1
        expect(t.field[2][1].adjacent_mines).to be 2
        expect(t.field[2][2].adjacent_mines).to be 0
      end
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

  describe 'private methods' do
    it '#generate_mines should be private' do
      expect do
        m.generate_mines
      end.to raise_error
    end
    it '#generate_adjacent_mine_counts should be private' do
      expect do
        m.generate_adjacent_mine_counts
      end.to raise_error
    end
  end

  describe 'take_turn' do
    let(:toy){ ToyMinefield.new }

    before(:each) do
      toy.field[0][0].place_mine
      toy.generate_adjacent_mine_counts
    end

    context '#clear' do
      it 'clears a cell with an adjacent mine' do
        turn = {row: 0, column: 1, action: 'C'}
        toy.take_turn(turn)
        expect(toy.field[0][1].cleared).to be true
      end

      it 'explodes a cell with a mine' do
        turn = {row: 0, column: 0, action: 'C'}
        toy.take_turn(turn)
        expect(toy.field[0][0].exploded?).to be true
      end

      it 'clears many cells if there are no adjacent mines' do
        turn = {row: 0, column: 2, action: 'C'}
        toy.take_turn(turn)
        expect(toy.field[0][0].cleared).to be false
        expect(toy.field[0][1].cleared).to be true
        expect(toy.field[0][2].cleared).to be true
        expect(toy.field[1][0].cleared).to be true
        expect(toy.field[1][1].cleared).to be true
        expect(toy.field[1][2].cleared).to be true
        expect(toy.field[2][0].cleared).to be true
        expect(toy.field[2][1].cleared).to be true
        expect(toy.field[2][2].cleared).to be true
      end
    end

    context '#auto_clear' do
      it 'auto-clears surrounding cells if flags match' do
        toy.field[0][0].flag
        toy.field[0][1].clear
        toy.auto_clear(0,1)
        expect(toy.field[0][0].cleared).to be false
        expect(toy.field[0][1].cleared).to be true
        expect(toy.field[0][2].cleared).to be true
        expect(toy.field[1][0].cleared).to be true
        expect(toy.field[1][1].cleared).to be true
        expect(toy.field[1][2].cleared).to be true
        expect(toy.field[2][0].cleared).to be true
        expect(toy.field[2][1].cleared).to be true
        expect(toy.field[2][2].cleared).to be true
      end
      it 'will not auto-clear surrounding cells if flags don\'t match' do
        toy.field[0][1].clear
        toy.auto_clear(0,1)
        expect(toy.field[0][0].cleared).to be false
        expect(toy.field[0][1].cleared).to be true
        expect(toy.field[0][2].cleared).to be false
        expect(toy.field[1][0].cleared).to be false
        expect(toy.field[1][1].cleared).to be false
        expect(toy.field[1][2].cleared).to be false
        expect(toy.field[2][0].cleared).to be false
        expect(toy.field[2][1].cleared).to be false
        expect(toy.field[2][2].cleared).to be false
      end
    end

    context '#flag and #unflag' do
      before(:each) do
        turn = {row: 0, column: 0, action: 'F'}
        toy.take_turn(turn)
      end
      it 'adds a flag' do
        expect(toy.field[0][0].flagged).to be true
      end
      it 'removes a flag' do
        turn = {row: 0, column: 0, action: 'U'}
        toy.take_turn(turn)
        expect(toy.field[0][0].flagged).to be false
      end
    end
  end

  describe '#lost?' do
    let(:t){ ToyMinefield.new }
    it 'returns true with any exploded mine' do
      t.field[0][0].place_mine
      t.field[0][0].clear
      expect(t.lost?).to be true
    end
  end
end