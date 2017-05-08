require 'rspec'
require 'board'

describe Board do
  b = Board.new

  describe '#initialize' do
    it 'creates a board' do
      expect(b).to be_a(Board)
    end
    it 'creates an array of 10 arrays by default' do
      expect(b.board_a.length).to eq(10)
      expect(b.board_a[0]).to be_a(Array)
    end

    it 'can create other size boards' do
      b11 = Board.new(size = 11)
      expect(b11.board_a.length).to eq(11)
    end

    it 'creates an array of arrays of cells' do
      expect(b.board_a[0][1]).to be_a(Cell)
    end

    it 'contains 9 mines by default' do
      expect(b.num_mines).to eq(9)
    end

    it 'should show remaining flags' do
      expect(b.num_flags).to eq(9)
    end
  end

  describe '#randomizer' do
    it 'generates an array' do
      expect(b.randomizer).to be_a(Array)
    end
    it 'generates an array with no duplicates' do
      #This code checks to see if there are any duplicates
      big_board = Board.new(size = 10, num_mines = 9)
      orig = big_board.randomizer.length
      no_dups = big_board.randomizer.uniq.length
      expect(orig).to eq(no_dups)
    end
    it 'generates an array equal in length to the number of mines' do
      b99 = Board.new(10, 99)
      expect(b99.randomizer.length).to eq(99)
    end
  end

  describe '#coordinator' do
    #Note: this only works for arrays for 10X10 and smaller
    it 'converts an integer into an array of two single digits' do
      expect(b.coordinator(1)).to eq([0,1])
      expect(b.coordinator(25)).to eq([2,5])
    end
  end

  describe '#assign_mines' do
    it 'calls randomizer' do
      allow(b).to receive(:randomizer).and_return([1,2,3])
      expect(b).to receive(:randomizer)
      b.assign_mines
    end
    it 'updates the @mine of different cells' do
      expect(b.assign_mines).to receive(:plant_mine)
    end
  end
end

describe Cell do
  c = Cell.new

  describe '#initialize' do
    it 'creates a cell' do
      expect(c).to be_a(Cell)
    end
    it 'does not have a mine by default' do
      expect(c.mine).to eq(false)
    end
    it 'is not marked by default' do
      expect(c.marked).to eq(false)
    end
    it 'is not cleared by default' do
      expect(c.cleared).to eq(false)
    end
    it 'is not near any mines by default' do
      expect(c.near_mines).to eq(0)
    end

    describe '#plant_mine' do
      it 'plants a mine' do
        expect(c.mine).to eq(false)
        c.plant_mine
        expect(c.mine).to eq(true)
      end
    end

    describe '#mark_mine' do
      it 'marks the cell as having a mine' do
        expect(c.marked).to eq(false)
        c.mark_mine
        expect(c.marked).to eq(true)
      end
    end
  end
end

r = Renderer.new(Board.new)
r.render_board
# describe Renderer do
#   r = Renderer.new(Board.new)
#   describe '#render_board' do
#     it 'outputs a string to the command line' do
#       expect(r).to receive(:puts)
#       r.render_board
#     end
#   end
# end
