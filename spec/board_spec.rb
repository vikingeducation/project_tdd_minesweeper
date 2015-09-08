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

  describe '#flag_cell' do
    it 'flags a cell' do
      b.flag_cell([0,0])

      expect(b.play_board[0][0]).to eq("F")
    end
  end

  context 'clicking a cell' do
    describe '#click_cell' do
      it 'blows up if the cell is a mine' do
        allow(b).to receive(:is_mine?).and_return(true) #why don't I need to pass an argument to is_mine?
        expect(b).to receive(:blow_up)
        b.click_cell([0,0])
      end

      it 'shows the cell if the cell is a number' do
        b.board =       
        [[0,1,1,1,0],
        [0,2,"x",2,0],
        [0,2,"x",2,0],
        [1,2,2,1,0],
        [1,"x",1,0,0]]

        b.click_cell([0,1])

        expect(b.play_board[0][1]).to eq(1)
      end

      it 'shows cluster if the cell is 0' do
        b.board =       
        [[0,1,1,1,0],
        [0,2,"x",2,0],
        [0,2,"x",2,0],
        [1,2,2,1,0],
        [1,"x",1,0,0]]

        expect(b).to receive(:show_cluster)

        b.click_cell([0,0])
      end
    end

  end

  # how should I test render?
  describe '#render' do
  end

  describe '#populate' do
    it 'populates the board with numbers based on the mine positions' do
      #allow(b).to receive(:populate).and_return("a")
      #expect(b.populate).to eq("a")
      input_board = 
      [[0,1,1,1,0],
      [0,2,"x",2,0],
      [0,2,"x",2,0],
      [1,2,2,1,0],
      [1,"x",1,0,0]]

      output_board = 
      [[0,1,nil,nil,nil],
      [0,2,nil,nil,nil],
      [0,2,nil,nil,nil],
      [1,2,nil,nil,nil],
      [nil,nil,nil,nil,nil]]

      b.board = input_board 
      
      b.click_cell([0,0])

      expect(b.play_board).to eq(output_board)
    end
  end

  describe '#cell_shown?' do
    it 'returns true if cell is already shown' do
      play_board =       
      [[0,1,nil,nil,nil],
      [0,2,nil,nil,nil],
      [0,2,nil,nil,nil],
      [1,2,nil,nil,nil],
      [nil,nil,nil,nil,nil]]

      data_board = 
      [[0,1,1,1,0],
      [0,2,"x",2,0],
      [0,2,"x",2,0],
      [1,2,2,1,0],
      [1,"x",1,0,0]]

      b.play_board = play_board
      b.board = data_board

      expect(b.cell_shown?([0,0])).to be_truthy
    end
  end

  describe '#win?' do
    it 'returns true when all non-mine cells are shown and all mine-cells are flagged' do
      play_board =       
      [[0,1,1,1,0],
      [0,2,"F",2,0],
      [0,2,"F",2,0],
      [1,2,2,1,0],
      [1,"F",1,0,0]]

      data_board = 
      [[0,1,1,1,0],
      [0,2,"x",2,0],
      [0,2,"x",2,0],
      [1,2,2,1,0],
      [1,"x",1,0,0]]

      b.play_board = play_board
      b.board = data_board

      expect(b.win?).to be_truthy
    end

    it 'does not return true if mine-cells are flagged but non-mine cells are not shown' do
      play_board =       
      [[0,1,1,1,0],
      [0,2,"F",2,0],
      [0,2,"F",2,0],
      [1,2,2,1,0],
      [1,"F",1,0,nil]]

      data_board = 
      [[0,1,1,1,0],
      [0,2,"x",2,0],
      [0,2,"x",2,0],
      [1,2,2,1,0],
      [1,"x",1,0,0]]

      b.play_board = play_board
      b.board = data_board

      expect(b.win?).to be_falsey
    end

    it 'does not return true if mine-cells are not all flagged' do
      play_board =       
      [[0,1,1,1,0],
      [0,2,"F",2,0],
      [0,2,nil,2,0],
      [1,2,2,1,0],
      [1,"F",1,0,nil]]

      data_board = 
      [[0,1,1,1,0],
      [0,2,"x",2,0],
      [0,2,"x",2,0],
      [1,2,2,1,0],
      [1,"x",1,0,0]]

      b.play_board = play_board
      b.board = data_board

      expect(b.win?).to be_falsey
    end
  end

end