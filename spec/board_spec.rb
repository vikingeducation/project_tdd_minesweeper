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
    # it 'updates the @mine of different cells' do
    #   allow(b.assign_mines).to receive(:plant_mine)
    #   expect(b.assign_mines).to receive(:plant_mine)
    # end
  end


  describe '#count_near_mines' do
    mock_board = Board.new
    mock_board.board_a = Array.new(3) {Array.new(3) {Cell.new}}
    mid_cell = [1,1]
    it 'returns 0 if no mines nearby' do
      expect(mock_board.count_near_mines(mid_cell)).to eq(0)
    end
    it 'returns the number of mines nearby' do
      mock_board.board_a[1][0].plant_mine
      expect(mock_board.count_near_mines(mid_cell)).to eq(1)
      mock_board.board_a[2][2].plant_mine
      expect(mock_board.count_near_mines(mid_cell)).to eq(2)
    end
  end

  describe '#in_bounds?' do
    it 'returns true if coordinates between 0 and 9' do
      expect(b.in_bounds?([4,5])).to eq(true)
    end

    it 'returns false if coordinates are out of bounds' do
      expect(b.in_bounds?([-1, 0])).to eq(false)
      expect(b.in_bounds?([0,10])).to eq(false)
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

describe Renderer do
  r = Renderer.new(Board.new)
  # describe '#render_board' do
  #   it 'outputs a string to the command line' do
  #     expect(r).to receive(:puts)
  #     r.render_board
  #   end
  # end
  describe '#get_symbol' do
    c = Cell.new

    it 'returns "# " by default' do
      expect(r.get_symbol(c)).to eq("# ")
    end

    it 'returns "^|" if marked' do
      c.mark_mine
      expect(r.get_symbol(c)).to eq("^|")
    end

    it 'returns a number if cleared and not mined' do
      c.clear
      c.near_mines = 2
      expect(r.get_symbol(c)).to eq("2 ".green)
    end

    it 'returns " " if cleared and no near mines' do
      c.clear
      c.near_mines = 0
      expect(r.get_symbol(c)).to eq("  ")
    end
  end
end
