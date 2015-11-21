require_relative '../lib/board.rb'
require 'rainbow'

describe Board do

  let(:board){ Board.new }
  let(:board2) do
    Board.new(5,5,[
      [0,1,0,0,1],
      [1,1,0,0,0],
      [0,0,0,0,0],
      [0,0,0,1,0],
      [0,0,0,0,0]
    ])
  end

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

  describe '#place_move' do

    it 'should not allow placement on an invalid square' do
      board.place_move([0,20])
    end

    it 'should change the state of a square to visible if valid' do
      board.place_move([1,1])
      expect(board.visible_board[0][0]).to_not eq(Rainbow('   ').bg(:white))
    end

    it "should expose that square's nearby mine count" do
      board2.place_move([1,1])
      expect(board2.visible_board[0][0]).to eq(Rainbow(" 3 ").red)
    end
  end

  describe '#place_flag' do
    it 'should not allow placement on a cleared square'
    it 'should not allow placement on an invalid location'
    it 'should show the flag on the rendered board'
    it 'should update the remaining flags attribute'
    it 'should not allow placement if no flags left'
  end

end