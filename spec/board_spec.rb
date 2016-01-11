require 'board'

describe 'Board' do

  describe '#initialize' do

    context 'with no parameters' do

      let(:default_board) { Board.new }

      it 'has a size of 10' do
        expect(default_board.size).to eq 10
      end

      it 'has 9 mines' do
        expect(default_board.mines).to eq 9
      end

    end

    context 'with custom parameters' do

      let(:custom_board) { Board.new(size: 100) }

      it 'has a size of 100' do
        expect(board.size).to eq 100
      end

      it 'has 99 mines' do
        expect(board.mines).to eq 99
      end

    end

  end
end
