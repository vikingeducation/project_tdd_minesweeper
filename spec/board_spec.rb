require './lib/board'
require 'spec_helper'

describe Board do

  let(:board) { described_class.new(4, 4, 5) }

  describe '#initialize' do
    it 'has 5 mines' do
      expect(board.mines).to eq(5)
    end
  end

  describe '#print_board' do
    it 'something'
  end

  describe '#click' do
    it 'returns "mine"' do 
      expect(board.click(2, 2)).to eql('mine')
    end
  end

end
