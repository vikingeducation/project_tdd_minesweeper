require 'minesweeper'

describe Minesweeper::Board do
  let(:board){Minesweeper::Board.new}

  describe '#initialize' do
    it "initializes a new board" do
      expect(board).to be_a(Minesweeper::Board)
    end
  end


  describe '#render' do
    it 'sends #render_board to view with a grid' do
      expect(board.view).to receive(:render_board).and_return("board")
      board.render
    end
  end


  # describe '#place_mines' do
  #   it "sets mines in the mine_map coordinates"
  # end

end
