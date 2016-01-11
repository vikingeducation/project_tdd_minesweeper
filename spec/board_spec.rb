require 'board'
require 'tile'

describe 'Board' do

  let(:board_3) { Board.new(size: 3) }
  
  describe '#initialize' do

    context 'with no parameters' do

      let(:default_board) { Board.new }

      it 'has a size of 10' do
        expect(default_board.size).to eq 10
      end

      it 'has 9 mines' do
        expect(default_board.mines).to eq 9
      end

      it 'creates a 2-D array of tiles' do
        expect(default_board.grid[0][0]).to be_a Tile
      end

    end

    context 'with custom parameters' do

      let(:custom_board) { Board.new(size: 100) }

      it 'has a size of 100' do
        expect(custom_board.size).to eq 100
      end

      it 'has 99 mines' do
        expect(custom_board.mines).to eq 99
      end

    end

  end

  describe  "#populate_the_mines" do

    it "places 2 mines on an empty board" do
        
        board_3.populate_mines([0,0])
        expect(board_3.mine_count).to eq(2) 
    end 

    it "places no mines on the starting coordinate" do
        
        30.times do 
          board_3.populate_mines([2,2])
          expect(board_3.grid[2][2].mine?).to eq(false) 
        end
    end


  end
    
end
