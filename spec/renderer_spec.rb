require 'rspec'
require 'renderer'

describe Renderer do
  r = Renderer.new(Board.new)

  describe '#clear_sur_cells' do
    it 'clears empty cells next to clear cells' do
      mock_board = Board.new
      mock_board.board_a = Array.new(3) {Array.new(3) {Cell.new}}
      mock_board.board_a[1][1].clear
      mock_board.clear_sur_cells([1,1])
      expect(mock_board.board_a[0][0].cleared).to eq(true)
      expect(mock_board.board_a[0][1].cleared).to eq(true)
      expect(mock_board.board_a[0][2].cleared).to eq(true)
      expect(mock_board.board_a[1][0].cleared).to eq(true)
      expect(mock_board.board_a[1][2].cleared).to eq(true)
      expect(mock_board.board_a[2][2].cleared).to eq(true)
    end

    it 'does not clear a cell that is mined' do
      mock_board = Board.new
      mock_board.board_a = Array.new(3) {Array.new(3) {Cell.new}}
      mock_board.board_a[2][2].plant_mine
      mock_board.clear_sur_cells([1,1])
      expect(mock_board.board_a[2][2].cleared).to eq(false)
    end
  end

  describe '#get_symbol' do
    c = Cell.new

    it 'returns "# " by default' do
      expect(r.get_symbol(c)).to eq("# ")
    end

    it 'returns "^|" if marked' do
      c.mark_mine
      expect(r.get_symbol(c)).to eq("^|")
    end

    it 'returns a number if cleared and not mined' do
      c.clear
      c.near_mines = 2
      expect(r.get_symbol(c)).to eq("2 ".green)
    end

    it 'returns " " if cleared and no near mines' do
      c.clear
      c.near_mines = 0
      expect(r.get_symbol(c)).to eq("  ")
    end
  end
end
