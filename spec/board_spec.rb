require 'board'
require 'pry'

describe Board do 

  let (:board) { Board.new }
  let (:game) { Game.new }

  describe "#initialize" do
    it 'initializes a board with 10 rows by default' do 
      expect(board.board.size).to eq(board.board_size)
    end

    it 'initializes a board with 10 columns by default' do 
      expect(board.board.transpose.size).to eq(board.board_size)
    end

    it 'initializes @flags to 9 by default' do 
      expect(board.flags).to eq(9)
    end
  end

  describe "#assign_mine_coordinates" do 
    before do 
      board.assign_mine_coordinates
    end
    it "randomly generates the number contained in @flags coordinates" do 
      expect(board.mine_coordinates.size).to eq(board.flags)
    end

    it "does not contain repeats" do 
      expect(board.mine_coordinates.uniq.size).to eq(board.flags)
    end
  end

  describe "#replace_repeat_mine_coordinates" do
    let(:board) { Board.new(10, 2) } 
    before do 
      board.mine_coordinates = [[2, 3], [2, 3]]
      board.replace_repeat_mine_coordinates
    end
    it "replaces duplicate mine coordinates" do 
      expect(board.mine_coordinates.uniq.size).to eq(board.flags)
    end
  end

  describe "#update_board" do 
    it "changes coordinate status to cleared based on Game.make_move" do 
      allow(game).to receive(:make_move).and_return([2,3,'c'])
      board.mine_coordinates = [[0, 2], [2, 2]]
      board.update_board(game.make_move)
      expect(board.board[1][2].clear).to be true
      expect(board.board[1][2].show).to eq(2)
    end

    it "changes coordinate status to flagged based on Game.make_move" do 
      allow(game).to receive(:make_move).and_return([2,3,'f'])
      board.update_board(game.make_move)
      expect(board.board[1][2].flag).to be true
      expect(board.board[1][2].show).to eq('F')
    end

    it "changes coordinate status to unflagged based on Game.make_move" do 
      allow(game).to receive(:make_move).and_return([2,3,'f'])
      board.board[1][2].flag = true
      board.update_board(game.make_move)
      expect(board.board[1][2].flag).to be false
      expect(board.board[1][2].show).to eq('*')
    end

     it "cannot flag a cleared cell" do 
      allow(game).to receive(:make_move).and_return([2,3,'c'])
      board.mine_coordinates = [[3, 3], [1, 3]]
      board.update_board(game.make_move)
      allow(game).to receive(:make_move).and_return([2,3,'f'])
      board.update_board(game.make_move)
      expect(board.board[1][2].flag).to be false
    end
  end

  describe "#check_surrounding_squares" do
    let(:board) { Board.new(10, 2) }  
    it "returns number of mines in adjacent squares in cleared square" do 
      board.mine_coordinates = [[0, 2], [2, 2]]
      allow(game).to receive(:make_move).and_return([2,3,'c'])
      board.update_board(game.make_move)
      expect(board.check_surrounding_squares(game.make_move)).to eq(2)
    end
  end

  describe "compute_adjacent_mines" do 
    let(:board) { Board.new(10, 2) } 
    it "assigns number of adjacent mines to each cell" do  
      board.mine_coordinates = [[1, 3], [8, 2]]
      allow(game).to receive(:make_move).and_return([2,3,'c'])
      board.compute_adjacent_mines(game.make_move)
      expect(board.board[1][2].adjacent_mines).to eq(1)
    end
  end
end
