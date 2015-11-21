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
      expect(board.place_move([0,20])).to eq(false)
    end

    it 'should change the state of a square to visible if valid' do
      board2.place_move([1,1])
      expect(board2.visible_board[0][0]).to_not eq(Rainbow('   ').bg(:white))
    end

    it "should expose that square's nearby mine count" do
      board2.place_move([1,1])
      expect(board2.visible_board[0][0]).to eq(Rainbow(" 3 ").red)
    end

    it 'should reveal all neighboring squares if mine count is 0' do
      board2.place_move([4,2])
      (3..5).each do |r|
        (1..3).each do |c|
          expect(board2.visible_board[r-1][c-1]).to_not eq(Rainbow('   ').bg(:white))
        end
      end
    end
  end

  describe '#place_flag' do
    it 'should not allow placement on a cleared square' do
      board2.place_move([1,1])
      expect(board2.place_flag([1,1])).to eq(false)
    end

    it 'should not allow placement on an invalid location' do
      expect(board.place_flag([0,20])).to eq(false)
    end

    it 'should show the flag on the rendered board' do
      board.place_flag([1,1])
      expect(board.visible_board[0][0]).to eq(Rainbow(' * ').red.bg(:white))
    end

    it 'should update the remaining flags attribute' do
      start = board.remaining_flags
      board.place_flag([1,1])
      expect(board.remaining_flags).to eq(start - 1)
    end

    it 'should not allow placement if no flags left' do
      b = Board.new(10, 0)
      expect(b.place_flag([1,1])).to eq(false)
    end
  end

end