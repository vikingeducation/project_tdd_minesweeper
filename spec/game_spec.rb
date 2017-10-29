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
    before do 
      allow(game).to receive(:validate_move).and_return(true)
    end
    it "takes in a string from STDIN" do
      allow(game).to receive(:gets).and_return('1, 2, 3') 
      expect(game).to receive(:gets)
      game.make_move
    end

    it "returns an array" do 
      allow(game).to receive(:gets).and_return('1,2,3')
      expect(game.make_move).to be_an(Array)
    end                                    
  end

  describe "#not_three_elements?" do 
    it "retruns true if the returned array contains fewer than three elements" do 
      allow(game).to receive(:move).and_return(['1', '2'])
      expect(game.not_three_elements?).to be true
    end

    it "returns true if the returned array contains more than three elements" do 
      allow(game).to receive(:move).and_return([1, 2, 3, 4])
      expect(game.not_three_elements?).to be true
    end
  end

  describe "#invalid_action?" do 
    it "returns true unless the last element of move is 'c' or 'f'" do 
      allow(game).to receive(:move).and_return([1, 2, 'd'])
      expect(game.invalid_action?).to be true
    end
  end

  describe "#out_of_bounds?" do
    it "returns true if the first element is larger than the board size" do 
      allow(game).to receive(:move).and_return([11, 2, 'c'])
      expect(game.out_of_bounds?).to be true
    end 

    it "returns true if the second element is larger than the board size" do 
      allow(game).to receive(:move).and_return([1, 22, 'c'])
      expect(game.out_of_bounds?).to be true
    end

    it "returns true if the first element is smaller than 1" do 
      allow(game).to receive(:move).and_return([0, 2, 'c'])
      expect(game.out_of_bounds?).to be true
    end  

     it "returns true if the second element is smaller than 1" do 
      allow(game).to receive(:move).and_return([1, 0, 'c'])
      expect(game.out_of_bounds?).to be true
    end
  end 

  describe "#already_clear?" do 
    it "returns true if the target cell is already clear" do
      game.board.board[0][0].clear_cell 
      allow(game).to receive(:move).and_return([1, 1, 'c'])
      expect(game.already_clear?).to be true
    end 
  end

  describe "#already_flagged?" do 
    it "returns true if the target cell is already flagged" do
      game.board.board[0][0].set_flag 
      allow(game).to receive(:move).and_return([1, 1, 'c'])
      expect(game.already_flagged?).to be true
    end 
  end



  describe "#validate_move" do
    it "calls make_move if not_three_elements? returns true" do 
      allow(game).to receive(:not_three_elements?).and_return(true, false)
      allow(game).to receive(:invalid_action?).and_return(false)
      allow(game).to receive(:out_of_bounds?).and_return(false)
      allow(game).to receive(:already_clear?).and_return(false)
      allow(game).to receive(:already_flagged?).and_return(false) 
      expect(game).to receive(:make_move)
      game.validate_move
    end

    it "calls make_move if invalid_action? returns true" do 
      allow(game).to receive(:not_three_elements?).and_return(false)
      allow(game).to receive(:invalid_action?).and_return(true, false)
      allow(game).to receive(:out_of_bounds?).and_return(false)
      allow(game).to receive(:already_clear?).and_return(false)
      allow(game).to receive(:already_flagged?).and_return(false) 
      expect(game).to receive(:make_move)
      game.validate_move
    end

    it "calls make_move if out_of_bounds? returns true" do 
      allow(game).to receive(:not_three_elements?).and_return(false)
      allow(game).to receive(:invalid_action?).and_return(false)
      allow(game).to receive(:out_of_bounds?).and_return(true, false)
      allow(game).to receive(:already_clear?).and_return(false)
      allow(game).to receive(:already_flagged?).and_return(false) 
      expect(game).to receive(:make_move)
      game.validate_move
    end

    it "calls make_move if already_clear? returns true" do 
      allow(game).to receive(:not_three_elements?).and_return(false)
      allow(game).to receive(:invalid_action?).and_return(false)
      allow(game).to receive(:out_of_bounds?).and_return(false)
      allow(game).to receive(:already_clear?).and_return(true, false)
      allow(game).to receive(:already_flagged?).and_return(false) 
      expect(game).to receive(:make_move)
      game.validate_move
    end

    it "rasies an error if already_flagged? returns true" do 
     allow(game).to receive(:not_three_elements?).and_return(false)
      allow(game).to receive(:invalid_action?).and_return(false)
      allow(game).to receive(:out_of_bounds?).and_return(false)
      allow(game).to receive(:already_clear?).and_return(false)
      allow(game).to receive(:already_flagged?).and_return(true, false) 
      expect(game).to receive(:make_move)
      game.validate_move
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