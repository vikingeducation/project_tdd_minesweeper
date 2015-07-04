require 'board'

describe "Board" do

  describe "#Initialize" do
    let(:board){Board.new}
    it 'should create Board with 10 rows' do
      expect(board.field.length).to be(10)
    end

    it 'should create Board with 10 columns' do
      expect(board.field[1].length).to be(10)
    end

    it 'has 9 mines' do
      count=0
      
      board.field.each do |row|
        row.each do  |elem|
          count+=1 if elem == "M" 
        end
      end
      expect(count).to be(9)
    end

    it "sets up game with 10 flags" do
      expect(board.flag_count).to eq(10)
    end
    
  end
  
end

