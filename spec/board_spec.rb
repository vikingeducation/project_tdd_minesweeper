require './lib/board'
require 'spec_helper'

describe Board do

  let(:board) { described_class.new(4, 4, 5) }
  let(:none) { described_class.new(2, 2, 0) }

  describe '#initialize' do
    it 'has 5 mines' do
      expect(board.mines).to eq(5)
    end
  end

  describe '#print_board' do
    it 'prints a string that contains "?"' do
      expect(board.print_board).to include("?")
    end

    it 'has no bombs in the printed board' do
      expect(none.print_board).not_to include("B")
    end
  end

  describe '#click' do
    it 'returns "mine"' do 
      expect(board.click(2, 2)).to change(@tiles[2][2].revealed)
    end
  end

end
