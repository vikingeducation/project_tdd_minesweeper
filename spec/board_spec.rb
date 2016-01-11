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
  end
end
