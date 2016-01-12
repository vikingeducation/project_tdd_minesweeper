require 'board'

describe Board do
  let(:board) { Board.build_board(10, 10, 5) }

  describe '.build_board' do
    it 'raises an ArgumentError if input arguments are not Fixnum' do
      expect{Board.build_board("hi", 1, 2)}.to raise_error(ArgumentError, "Need integer inputs!")
    end

    it 'raises an ArgumentError unless height, width, mines are all positive' do
      expect{Board.build_board(-1,10,9)}.to raise_error(ArgumentError, "Inputs must be positive!")
    end

    it 'raises an ArgumentError if mine count is greater than grid size' do
      expect{Board.build_board(1,1,2)}.to raise_error(ArgumentError, "Too many mines!")
    end

    it 'initializes an instance of board' do
      expect(board).to be_a(Board)
    end

    it 'initializes an array in @board' do
      expect(board.board).to be_a(Array)
    end

    describe '#fill_board_with_squares' do
      it 'fills every coordinate with Square' do
        square_checker = true
        board_copy = board.board
        board_copy.each do |row|
          row.each do |col|
            square_checker = false if !col.is_a?(Square)
          end
        end
        expect(square_checker).to eq(true)
      end

      it 'correctly plants number of mines' do
        # test_board = Board.build_board(3,3,1)
        # expect(test_board).to receive(:fill_board_with_squares).and_return(test_board.board)
        # test_board = Board.build_board(3,3,1)
        expect(board.mine_count).to eq(5)
      end
    end

    describe '#count_proximities' do
      it 'runs count_proximities' do
        board_copy = board.board
        adjacent_mine_count = 0
        board_copy.each do |row|
          row.each do |col|
            if col.proximity > 0
              adjacent_mine_count = col.proximity
              break
            end
          end
        end
        expect(adjacent_mine_count).to be_between(0, 8).inclusive
      end
    end
  end

  describe '#mine_count' do
    it 'returns correct number of mines planted in board' do
      new_board = Board.build_board(5,5,3)
      expect(new_board.mine_count).to eq(3)
    end
  end

  #build explicit test case
  let(:test_board) { Board.build_board(3,3,3) }
  let(:e) { Square.build_empty }
  let(:m) { Square.build_mine }
  let(:small_test_board) { [[m,m,m],
                            [e,e,e],
                            [e,e,e]]}

  #set up hooks for subsequent tests
  before(:each) do
    #run count_proximities, or its effect since it's private method
    small_test_board[1][0].proximity = 2
    small_test_board[1][1].proximity = 3
    small_test_board[1][2].proximity = 2
    test_board.instance_variable_set(:@board, small_test_board)
  end

  describe '#clear_squares' do
    it 'will set @cleared instance var of squares to true' do
      #run method clear_squares at loc (0,3)
      test_board.clear_squares(1, 0)
      copy_board = test_board.board

      clear_checker = true
      (1..2).each do |row|
        (0..2).each do |col|
          clear_checker = false if !copy_board[row][col].cleared
        end
      end

      expect(clear_checker).to eq(true)
    end
  end

  describe '#process_move' do
    it 'returns 0 at mine location' do
      expect(test_board.process_move(0,0)).to eq(0)
    end

    it 'calls clear_squares at non-mine location' do
      expect(test_board).to receive(:clear_squares)
      test_board.process_move(1,0)
    end

    it 'returns 1 if the location is already cleared' do
      small_test_board[1][0].cleared = true
      test_board.instance_variable_set(:@board, small_test_board)
      expect(test_board.process_move(1,0)).to eq(1)
    end
  end
end
