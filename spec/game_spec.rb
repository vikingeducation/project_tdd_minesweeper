require 'game'

describe Game do 

  let(:game) { Game.new }
  let(:board) { Board.new }

  describe "#intialize" do 
    it "intializes a new Board object" do 
      expect(game.board).to be_a(Board)
    end
  end

  describe "#make_move" do 
    it "takes in a string from STDIN" do
      allow(game).to receive(:gets).and_return('1, 2, 3') 
      expect(game).to receive(:gets)
      game.make_move
    end

    it "raises an error if the received string contains fewer than two commas" do 
      allow(game).to receive(:gets).and_return('')
      expect{ game.make_move }.to raise_error
    end

    it "returns an array" do 
      allow(game).to receive(:gets).and_return('1,2,3')
      expect(game.make_move).to be_an(Array)
    end                                    

    it "raises error if the returned array contains fewer than three elements" do 
      allow(game).to receive(:gets).and_return('1, 2')
      expect{game.make_move}.to raise_error
    end
  end

  describe "#lose" do 
    it "returns true if player attempts to clear a mined cell" do 
      game.board.mine_coordinates = [[1, 2]]
      allow(game).to receive(:move).and_return([2, 3, 'c'])
      expect(game.lose?).to be_truthy
    end

    it "returns a false if player makes a move that does not trip a mine" do 
      game.board.mine_coordinates = [[1, 2]]
      allow(game).to receive(:move).and_return([5, 6, 'c'])
      expect(game.lose?).to be_falsy
    end
  end

  describe "#win?" do 
    it "returns true if player wins the game" do 
      game.board.board = [[Cell.new, Cell.new]]
      game.board.board[0][0].set_flag 
      game.board.board[0][1].clear_cell
      game.board.flags = 0
      expect(game.win?).to be true
    end

    it "returns false if the player has not won the game" do 
      game.board.board = [[Cell.new, Cell.new]]
      game.board.board[0][1].clear_cell
      game.board.flags = 0
      expect(game.win?).to be false
    end
  end


  describe "#game_over?" do
    it "returns true if player wins" do 
      allow(game).to receive(:win?).and_return(true)
      expect(game.game_over?).to be true
    end

    it "returns true if player loses" do 
      allow(game).to receive(:lose?).and_return(true)
      expect(game.game_over?).to be true
    end

    it "returns false if player neither wins nor loses" do
      allow(game).to receive(:win?).and_return(false) 
      allow(game).to receive(:lose?).and_return(false)
      expect(game.game_over?).to be false
    end
  end

  describe "#clear_board" do 
    it "exposes mine loactions when game is over" do 
      cell = game.board.board[0][0]
      cell.set_mine
      allow(game).to receive(:game_over?).and_return(true)
      game.clear_board
      expect(cell.show).to eq('B')
    end
  end

end