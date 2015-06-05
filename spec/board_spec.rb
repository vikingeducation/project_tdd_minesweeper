require 'board'

describe Board do

  describe "#initialize" do

    it "creates (Height * Width) new Squares" do
      expect(Square).to receive(:new).exactly(100).times
      Board.new(10, 10)
    end

    it "passes x,y coordinates to squares" do
      expect(Square).to receive(:new).with(1,1)
      expect(Square).to receive(:new).with(1,2)
      expect(Square).to receive(:new).with(2,1)
      expect(Square).to receive(:new).with(2,2)
      Board.new(2, 2)
    end

  end


  describe "#row_status" do
    let(:board) { Board.new(10, 10) }

    it "outputs an array" do
      expect(board.row_status(3)).to be_an(Array)
    end

    it "makes output array the same size as the width of the board" do
      expect(board.row_status(3).size).to eq(10)
    end

    it "displays the square's status in the array" do
      small_board = Board.new(3,3)
      expect(small_board.row_status(3)).to eq(["O","O","O"])
    end

    #it "displays flagged status appropriately" do
    #  expect(board_one_flag.row_status(3)).to eq(["O","O","@"])
    #end

  end


end