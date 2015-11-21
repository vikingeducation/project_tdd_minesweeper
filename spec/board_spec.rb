require_relative '../lib/board.rb'

describe Board do

  let(:board){ Board.new }

  describe '#initialize' do

    it 'should be a Board' do
      expect(board).to be_a(Board)
    end

    it 'should be 10x10 by default' do
      expect(board.mine_locations.size).to eq(10)
      expect(board.mine_locations.select{|col| col.size == 10}.size).to eq(10)
    end

    it 'should have 9 mines by default' do
      expect(board.mines).to eq(9)
      expect(board.mine_locations.map{|i| i.inject(:+)}.inject(:+)).to eq(9)
    end

    it 'should show remaining flags' do
      expect(board.remaining_flags).to eq(9)
    end
  end

  describe '#place_turn' do

    it 'should not allow placement on an invalid square'
    it 'should change the state of a square to visible if valid'
  end

end