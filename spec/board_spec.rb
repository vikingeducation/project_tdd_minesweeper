require_relative '../lib/board.rb'

describe Board do

  let(:board){Board.new}

  describe '#initialize' do
    it 'creates a new board' do
      expect(board).to be_a(Board)
    end
  end

  describe '#loss?(move)' do
    it 'recognizes a non-losing move' do
      move = [3,4]
      expect(board.loss?(move)).to eq(false)
    end

    it 'recognizes a losing move' do
      move = [1,1]
      expect(board.loss?(move)).to eq(true)
    end

    it 'recognizes a different losing move' do
      move = [2,1]
      expect(board.loss?(move)).to eq(true)
    end
  end
end
