require 'board'

describe Board do

  context "starting game with empty board" do

      describe "#initialize" do

        let(:board) { Board.new }

        it "creates an empty board" do
          expect(board.board.length).to eq(9)  #rows
          expect(board.board[1].length).to eq(9)
        end



      end

  end

end