require 'board'
# require 'cell'

describe Board do
  describe '#render' do
    let(:minimum_size) { Board::MIN_SIZE }
    let(:maximum_size) { Board::MAX_SIZE }

    describe 'with no provided size' do
      let(:board) { Board.new }

      it 'renders a minimum size board by default' do
        expect(board.render.length).to equal minimum_size
        board.render.each do |line|
          expect(line.length).to equal minimum_size
        end
      end
    end #no provided size

    describe 'with a custom board size' do
      let(:board) { Board.new(board_size) }
      let(:board_size) { minimum_size }

      describe 'when 10 is provided' do
        let(:board_size) { 10 }
        it 'renders an 10 x 10 grid' do
          expect(board.render.length).to eq(board_size)
          board.render.each do |line|
            expect(line.length).to eq(board_size)
          end
        end
      end

      describe 'when size is below the lower limit' do
        let(:board_size) { minimum_size - 1 }
        it('raises an error') { expect{ board.render }.to raise_error(ArgumentError) }
      end

      describe 'when size is above the upper limit' do
        let(:board_size) { maximum_size + 1 }
        it('raises an error') { expect{ board.render }.to raise_error(ArgumentError) }
      end

      it 'has hint values in the cells' do
        row_hint_total = board.render.first.map(&:value).reduce(&:+)
        expect(row_hint_total).to be > 0
      end

    end #custom board

  end #render
end #Board