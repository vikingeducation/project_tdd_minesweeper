require_relative '../lib/board.rb'

describe Board do

  let(:board){ Board.new }

  describe '#initialize' do

    it 'should be a Board' do
      expect(board).to be_a(Board)
    end

    it 'should be 10x10 by default' do
      expect(board.board.size).to eq(10)
      expect(board.board.select{|col| col.size == 10}.size).to eq(10)
    end

    it 'should have 9 mines by default' do
      expect(board.mines).to eq(9)
      expect(board.board.map{|i| i.inject(:+)}.inject(:+)).to eq(9)
    end

    it 'should show remaining flags' do
      expect(board.remaining_flags).to eq(9)
    end
  end

end