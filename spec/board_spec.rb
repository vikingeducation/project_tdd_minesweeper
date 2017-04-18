RSpec.describe Board do
  let(:board) {Board.new}

  describe 'new board' do
    it 'is a mine field' do
      expect(board.mine_field).to be_a MineField
    end
  end

  describe 'validating cell availability' do
    context 'cell is on the board' do
      it 'is a available when not already cleared' do
        expect(board.cell_available?('3, 3')).to be_truthy
      end

      it 'is unavailable when cell is already cleared' do
        allow(board.mine_field.find(1, 2)).to receive(:mined?) { false }

        board.record_move('1, 2', 'c')
        expect(board.cell_available?('1, 2')).to be_falsey
      end
    end

    context 'cell is not on the board' do
      it 'is unavailable' do
        expect(board.cell_available?('1, -1')).to be_falsey
        expect(board.cell_available?('11, 1')).to be_falsey
        expect(board.cell_available?('1, 11')).to be_falsey
      end
    end
  end

  describe 'recording a move' do
    describe 'clearing a cell' do
      context 'no mine in cell' do
        it 'clears the cell' do
          cell_to_clear = board.mine_field.find(1, 2)
          allow(cell_to_clear).to receive(:mined?) { false }

          board.record_move('1, 2', 'c')
          expect(cell_to_clear.cleared?).to be_truthy
        end
      end

      context 'cell is mined' do
        it 'raises an error' do
          allow(board.mine_field.find(1, 2)).to receive(:mined?) { true }

          expect {
            board.record_move('1,2', 'c')
          }.to raise_error Errors::CellWasMinedError

        end
      end
    end
  end

  describe '#to_s' do
    describe 'initial board' do
      let(:rendered_board) { expected_board }

      it 'renders a blank board with rows and columns marked' do
        expect(board.to_s).to eq rendered_board
      end
    end
  end

  def expected_board
    <<~EOB
         | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10|
         -----------------------------------------
      1  | ? | ? | ? | ? | ? | ? | ? | ? | ? | ? |
         -----------------------------------------
      2  | ? | ? | ? | ? | ? | ? | ? | ? | ? | ? |
         -----------------------------------------
      3  | ? | ? | ? | ? | ? | ? | ? | ? | ? | ? |
         -----------------------------------------
      4  | ? | ? | ? | ? | ? | ? | ? | ? | ? | ? |
         -----------------------------------------
      5  | ? | ? | ? | ? | ? | ? | ? | ? | ? | ? |
         -----------------------------------------
      6  | ? | ? | ? | ? | ? | ? | ? | ? | ? | ? |
         -----------------------------------------
      7  | ? | ? | ? | ? | ? | ? | ? | ? | ? | ? |
         -----------------------------------------
      8  | ? | ? | ? | ? | ? | ? | ? | ? | ? | ? |
         -----------------------------------------
      9  | ? | ? | ? | ? | ? | ? | ? | ? | ? | ? |
         -----------------------------------------
      10 | ? | ? | ? | ? | ? | ? | ? | ? | ? | ? |
         -----------------------------------------

      Flags left: 9

    EOB
  end
end
