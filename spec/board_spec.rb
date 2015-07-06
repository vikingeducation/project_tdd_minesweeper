require 'board'

describe "Board" do
  let(:board){Board.new}
  let(:new_board) {Array.new(10) { Array.new(10) {{:hint => 0, :flag => false, :mine => false, :revealed =>false}}  }}
  let(:s_board) {Array.new(4) { Array.new(4) {{:hint => 0, :flag => false, :mine => false, :revealed =>false}}  }}
  describe "#Initialize" do

    it 'should create Board with 10 rows' do
      expect(board.field.size).to be(10)
    end

    it 'should create Board with 10 columns' do
      expect(board.field[1].length).to be(10)
    end

    it 'has 9 mines' do
      count=0

      board.field.each do |row|
        row.each do |h|
          count+=1 if h[:mine]
        end
      end
      expect(count).to be(9)
    end

    it "sets up game with 10 flags" do
      expect(board.flag_count).to eq(10)
    end

    it "should have hints for mines" do
      board.field = new_board
      board.field[1][1][:mine] = true
      board.generate_hints
      expect(board.field[0][0][:hint]).to eq(1)
    end

    it "should properly count amount of mines for the hint" do
      board.field = new_board
      board.field[1][1][:mine] = true
      board.field[1][0][:mine] = true
      board.generate_hints
      expect(board.field[0][0][:hint]).to eq(2)
    end

  end

  describe "Moves on board" do

    describe "#flag" do

      it "flags square when flag" do
        board.flag(1,1)
        expect(board.field[1][1][:flag]).to be(true)
      end

      it "should not place flag if out of flags" do
        allow(board).to receive(:flag_count).and_return(0)
        board.flag(1,1)
        expect(board.field[1][1][:flag]).to be(false)
      end

      it "should not place flag if out of flags" do
        allow(board).to receive(:flag_count).and_return(0)
        board.flag(1,1)
        expect(board.field[1][1][:flag]).to be(false)
      end

      it "should decrease flag's amount when a flag is used" do
        board.flag(1,1)
        expect(board.flag_count).to eq(9)
      end

      it "should increase flag's amount when a flag is removed" do 
        board.flag(1,1)
        board.flag(1,1)
        expect(board.flag_count).to eq(10)
      end
    end

  end

  describe "Clearing the board" do
    it "cleares the square when played" do
      board.field[1][1][:mine] = false
      board.clear(1,1)
      expect(board.field[1][1][:revealed]).to be(true)
    end

    it "check that game is over when mine is revealed" do
      board.field[1][1][:mine] = true
      board.clear(1,1)
      expect(board.game_over?).to be true
    end

    it "cleares all obvious squares" do
      board.field = s_board
      board.clear(0,0)
      expect(board[2][1][:hint]).to eq(1)
    end

    
  end



end

