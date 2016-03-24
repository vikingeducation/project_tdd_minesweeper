require "board"

describe Board do
  let(:board) {Board.new}
  context "#initialize" do
    it "should create a 10 x 10 board on start" do
      expect(board.board_size).to eq(10)
    end

    it "should create custom size board if pass argument" do
      board = Board.new(20,9)
      expect(board.board_size).to eq(20)
    end

    it "should create 9 bombs on start" do
      expect(board.bombs).to eq(9)
    end

    it "should create a custom number of bombs if pass argument" do
      board = Board.new(10,19)
      expect(board.bombs).to eq(19)
    end

    it "should have the same number of bombs and flags" do

      flags = board.instance_variable_get(:@flags_nb)
      expect(flags).to eq(board.bombs)
    end

    it "should call #create_board" do
      expect_any_instance_of(Board).to receive(:create_board).with(10)
      Board.new
    end

    it "should not be game_over when start" do
      expect(Board.new.game_over).to eq(false)
    end
  end

  context "#check_move" do
    it "should call #valid_move?" do
      expect(board).to receive(:valid_move?).with([10,10,"c"])
      board.check_move([10,10,"c"])
    end
  end

  context "#valid_move?" do

    it "should set game over if enter 'q'" do
      board.valid_move?("Q")
      expect(board.game_over).to eq(true)
    end
  end

  context "#create_board" do
    it "should create a board of Cells" do
      board.board.each do |col_idx, col|
        expect(col.all? do |row_idx, row|
          row.is_a?(Cell)
        end).to eq(true)
      end
    end
  end



end