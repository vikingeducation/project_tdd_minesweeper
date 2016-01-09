require 'board'

describe Board do

  let(:board) { Board.new }

  describe "#initialize" do
    it "creates a 10x10 board by default" do
      expect(board.grid.size).to eq 10
    end

    it "creates a board the size passed" do
      expect(Board.new(size: 20).grid.size).to eq 20
    end

    it "starts with 9 mines by default" do
      expect(board.mines).to eq 9
    end

    it "can have a different number of mines" do
      expect(Board.new(mines: 20).mines).to eq 20
    end

    it "should have the same number of flags as mines" do
      expect(board.flags).to eq(board.mines)
    end
  end

  describe "#populate_board" do
    it "starting coordinate has no mine" do
      
    end
  end

  describe "#render" do

  end
end
