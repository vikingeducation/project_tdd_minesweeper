require 'board'

describe "Board" do
  let(:board){Board.new}
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

  describe "Moves on board"

    it "flags square when flag" do
      board.flag(1,1)
      expect(board.field[1][1][:flag]).to be(true)
    end


    it "cleares the square when played" do
      board.clear(1,1)
      expect(board.field[1][1][:revealed]).to be(true)

    end

    it "check that game is over when mine is revealed" 

  end
 

  
end

