require_relative '../lib/board.rb'

describe Board do

  let(:board){Board.new}

  describe '#initialize' do
    it 'creates a new board' do
      expect(board).to be_a(Board)
    end
  end

  describe '#has_bomb?(move)' do
    it 'recognizes a non-losing move' do
      @mine_array = [[0,0],[0,1],[0,2],[0,3],[0,4],[0,5],[0,6],[0,7],[0,8]]
      move = [3,4]
      expect(board.has_bomb?(move)).to eq(false)
    end

    it 'recognizes a losing move' do
      @mine_array = [[0,0],[0,1],[0,2],[0,3],[0,4],[0,5],[0,6],[0,7],[0,8]]
      move = [0,0]
      expect(board.has_bomb?(move)).to eq(true)
    end

    it 'recognizes a different losing move' do
      @mine_array = [[0,0],[0,1],[0,2],[0,3],[0,4],[0,5],[0,6],[0,7],[0,8]]
      move = [0,4]
      expect(board.has_bomb?(move)).to eq(true)
    end
  end

  describe '#neighbors' do
    before do
      allow(STDOUT).to receive(:print)
    end
    it 'correctly find neighboring cells' do
      expect(board.neighbors(1,1)).to eq([[0,0],[0,1],[0,2],[1,0],[1,2],[2,0],[2,1],[2,2]])
    end
  end
end
