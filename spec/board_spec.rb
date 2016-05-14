require 'board'
require 'tile'

describe Board do

  let(:board) { Board.new }

  context "#initialize" do
    it "creates a default height of 10" do
      expect(board.height).to eq(10)
    end

    it "creates a default width of 10" do
      expect(board.width).to eq(10)
    end

    it "creates 9 mines by default" do
      expect(board.mines).to eq(9)
    end
  end

  context "#create_board" do

    before(:each) { board.create_board }

    it "creates 10 sub arrays" do
      expect(board.tiles.length).to eq(10)
    end

    it "creates 10 tiles in each sub array" do
      expect(board.tiles[0].length).to eq(10)
    end
  end

end
