require 'board'

describe Board do
	let(:board){Board.new}
   describe "#initialize" do

    it "should create a Board object" do
      expect(Board.new).to be_a(Board)
    end

    it "should be 10x10 by default" do
      expect(board.gameboard.size).to eq(100)
    end

    it "should have 9 mines by default" do
    	expect(board.mines).to eq(9)
    end

    it "has set all mines" do
      mine_count = 0
      board.gameboard.each do |cell|
        mine_count += 1 if cell.mine == 1
      end
      expect(mine_count).to eq(9)
    end
  end

  describe "#render" do
    it "should render initial gameboard" do
      expect(board.render).to be_truthy
    end

  end

  describe "game play" do

    it "should show remaining flags" do
    	expect(board.remaining_flags).to eq(9)
    end

    context "clearing squares" do

      specify "player can change state of square" do
        initial_state = board.gameboard[1].state
        board.change_state_of_square(1)
        expect(board.gameboard[1].state).to_not eq(initial_state)
      end

      #assume @mine == 0
      it "should appear clear when cleared by player" do
        board.change_state_of_square(3)
        expect(board.gameboard[3].print_value).to eq(" \u25A2")
      end
    end
  end
end
