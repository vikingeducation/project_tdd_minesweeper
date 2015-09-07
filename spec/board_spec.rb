# rspec board

require 'board'

describe Board do

  let(:b){Board.new}

  describe '#initialize' do
    it 'creates an empty 5x5 board by default' do
      expect(b.board.size * b.board[0].size).to eq(25)
      # expect(b.board).to eq(
      #   [[nil, nil, nil, nil, nil, nil, nil, nil, nil, nil], 
      #   [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil], 
      #   [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil], 
      #   [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil], 
      #   [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil], 
      #   [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil], 
      #   [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil], 
      #   [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil], 
      #   [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil], 
      #   [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil]] )
    end
  end

  describe '#populate' do
    it 'populates the board with numbers based on the mine positions' do
      #allow(b).to receive(:populate).and_return("a")
      #expect(b.populate).to eq("a")
      b.board = 
      [[0,0,0,0,0],
      [0,0,"x",0,0],
      [0,0,"x",0,0],
      [0,0,0,0,0],
      [0,"x",0,0,0]]
      
      b.populate

      expect(b.board).to eq(
      [[0,1,1,1,0],
      [0,2,"x",2,0],
      [0,2,"x",2,0],
      [1,2,2,1,0],
      [1,"x",1,0,0]])
    end
  end

  describe '#is_mine?' do
    it 'returns true if a cell is a mine' do
      cell = "x"
      expect(b.is_mine?(cell)).to be_truthy
    end

    it 'returns false if a cell is not a mine' do
      cell = "o"
      expect(b.is_mine?(cell)).to be_falsey
    end
  end

  describe '#num_mines' do
    it 'counts the number of mines surrounding a cell' do
      b.board =       
      [[0,0,0,0,0],
      [0,0,"x",0,0],
      [0,0,"x",0,0],
      [0,0,0,0,0],
      [0,"x",0,0,0]]

      expect(b.num_mines([1,3])).to eq(2)
    end

    it 'correctly counts the number of mines surrounding a corner or edge cell' do
      b.board = 
      [[0,0,0,0,"x"],
      ["x",0,0,0,0],
      [0,0,0,0,0],
      [0,0,0,0,0],
      [0,"x",0,0,"x"]]

      expect(b.num_mines([0,0])).to eq(1)
    end
  end

end