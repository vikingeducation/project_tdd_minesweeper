require 'board'
describe Board do
  let(:columns) {10}
  let(:mines) {9}
  let(:board) {Board.new(columns, mines)}
  let(:init_board) {}

  describe '#init' do
    it 'creates a board' do
      expect(board).to be_a(Board)
    end
    it 'initializes the number of columns' do
      expect(board.columns).to eq(10)
    end
    it 'initializes the number of mines' do
      expect(board.mines).to eq(9)
    end
    it 'initialize the number of remaining_flags' do
      expect(board.remaining_flags).to eq(9)
    end
    it 'initializes a starting amount of game time in seconds' do
      expect(board.game_time).to eq(62)
    end
    it 'initializes a mine array equal to the number of squares' do
      expect(board.mine_arr.length).to eq(columns ** 2)
    end
  end
end
