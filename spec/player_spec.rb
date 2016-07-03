require_relative '../lib/board.rb'
require_relative '../lib/square.rb'
require_relative '../lib/player.rb'
describe Player do
  describe "#initialize" do
    it "returns a player" do
      expect(subject).to be_a(Player)
    end
  end
  before(:each) do
    @board = Board.new
  end
  describe "#clear_square" do
    it "player clears the square where the cursor is preset" do
      subject.clear_square(@board)
      expect(@board.cur_square.state).to eq(:cleared)
    end
    it "player cannot clear the square where mine is preset" do
      @board.cur_square.make_mine
      subject.clear_square(@board)
      expect(@board.cur_square.state).to eq(:none)
    end

    it "gameover if player clears a square with a mine in it" do
      @board.cur_square.make_mine
      expect(subject.clear_square(@board)).to eq(nil)
    end
  end
  describe "#flag_square" do
    it "player flags the square where the cursor is preset" do
      subject.flag_square(@board)
      expect(@board.cur_square.state).to eq(:flaged)
    end
    it "cleared squares cannot be flaged" do
      subject.clear_square(@board)
      subject.flag_square(@board)
      expect(@board.cur_square.state).to eq(:cleared)
    end

    it "flaged square can change to :none" do
      subject.flag_square(@board)
      subject.unflag_square(@board)
      expect(@board.cur_square.state).to eq(:none)
    end
  end
end