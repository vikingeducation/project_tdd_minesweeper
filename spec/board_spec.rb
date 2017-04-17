RSpec.describe Board do
  let(:board) {Board.new}

  describe 'new board' do
    it 'is 9x9 by default' do
      expect(board.mine_field.size).to eq 100
    end

    it 'is filled with cells' do
      expect(board.mine_field.first).to be_a Cell
    end
  end

  describe 'board of cells' do
    describe 'coordinates' do
      context 'first row' do
        it 'has x coordinate of 1' do
          cell1 = board.mine_field[0]
          cell9 = board.mine_field[8]

          expect(cell1.coordinates[:x]).to eq 1
          expect(cell9.coordinates[:x]).to eq 1
        end
      end

      context 'second row' do
        it 'has x coordinate of 2' do
          cell11 = board.mine_field[10]
          cell19 = board.mine_field[18]

          expect(cell11.coordinates[:x]).to eq 2
          expect(cell19.coordinates[:x]).to eq 2
        end
      end

      context 'columns' do
        it 'has y coordinates in ascending order for each row' do
          cell1 = board.mine_field[0]
          cell2 = board.mine_field[1]
          cell11 = board.mine_field[10]
          cell12 = board.mine_field[11]

          expect(cell1.coordinates[:y]).to eq 1
          expect(cell2.coordinates[:y]).to eq 2
          expect(cell11.coordinates[:y]).to eq 1
          expect(cell12.coordinates[:y]).to eq 2
        end
      end
    end
  end

  describe 'choosing a cell' do
    context 'cell is on the board' do
      it 'is a valid move when not already cleared' do
        expect(board.valid_move?('3, 3')).to be_truthy
      end

      it 'is an invalid move when cell is already cleared' do
        board.record_move('1, 2', 'c')
        expect(board.valid_move?('1, 2')).to be_falsey
      end
    end

    context 'cell is not on the board' do
      it 'is an invalid move' do
        expect(board.valid_move?('1, -1')).to be_falsey
        expect(board.valid_move?('11, 1')).to be_falsey
        expect(board.valid_move?('1, 11')).to be_falsey
      end
    end
  end

  describe 'making a move' do
    describe 'clearing a cell' do
      it 'clears the cell' do
        board.record_move('1, 2', 'c')
        expect(board.mine_field[1].cleared?).to be_truthy
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
