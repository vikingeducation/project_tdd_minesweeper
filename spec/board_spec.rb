# spec/board_spec.rb

require 'board'

describe Board do 
  describe '#initialize' do
    it 'creates a board of type Board' do
      expect(Board.new).is_a? Board
    end

    it "accepts a board array when created" do
      expect {Board.new( Array.new(10){ Array.new(10) } )}.not_to raise_error
    end
  end

   describe "#render" do
    it "displays empty board at the beginning of the game" do
      expect{subject.render}.to output("\n----------\n----------\n----------\n----------\n----------\n----------\n----------\n----------\n----------\n----------\n\n").to_stdout
    end

    it "displays full board" do
      full_board = Board.new([
        ["1", "C", "X", "F", "C", "C", "F", "2", "F", "1"],
        ["1", "C", "X", "F", "C", "C", "F", "2", "F", "1"],
        ["1", "C", "X", "F", "C", "C", "F", "2", "F", "1"],
        ["1", "C", "X", "F", "C", "C", "F", "2", "F", "1"],
        ["1", "C", "X", "F", "C", "C", "F", "2", "F", "1"],
        ["1", "C", "X", "F", "C", "C", "F", "2", "F", "1"],
        ["1", "C", "X", "F", "C", "C", "F", "2", "F", "1"],
        ["1", "C", "X", "F", "C", "C", "F", "2", "F", "1"],
        ["1", "C", "X", "F", "C", "C", "F", "2", "F", "1"],
        ["1", "C", "1", "F", "C", "C", "F", "2", "F", "1"]] )

      expect{full_board.render}.to output("\n1CXFCCF2F1\n1CXFCCF2F1\n1CXFCCF2F1\n1CXFCCF2F1\n1CXFCCF2F1\n1CXFCCF2F1\n1CXFCCF2F1\n1CXFCCF2F1\n1CXFCCF2F1\n1C1FCCF2F1\n\n").to_stdout
    end

    it "displays an in-progress board" do
      in_progress_board = Board.new([
        ["1", "C", "X", "F", "C", "C", "F", "2", "F", "1"],
        ["1", "C", "X", "F", "C", "C", "F", "2", "F", "1"],
        ["1", "C", nil, "F", "C", "C", "F", "2", "F", "1"],
        ["1", "C", nil, "F", "C", "C", "F", "2", "F", "1"],
        ["1", "C", nil, "F", "C", "C", "F", "2", "F", "1"],
        ["1", "C", "X", "F", "C", "C", "F", "2", "F", "1"],
        ["1", "C", "X", "F", "C", "C", "F", "2", "F", nil],
        ["1", "C", "X", "F", "C", "C", "F", "2", "F", nil],
        ["1", "C", "X", "F", "C", "C", "F", "2", "F", nil],
        ["1", "C", "1", "F", "C", "C", "F", "2", "F", nil]] )

      expect{in_progress_board.render}.to output("\n1C-FCCF2F1\n1C-FCCF2F1\n1C-FCCF2F1\n1C-FCCF2F1\n1C-FCCF2F1\n1C-FCCF2F1\n1C-FCCF2F-\n1C-FCCF2F-\n1C-FCCF2F-\n1C1FCCF2F-\n\n").to_stdout
    end
  end

    describe "#add_to_board" do 
    it "sets valid piece in place" do
      subject.add_to_board([0, 0], "C")
      expect(subject.board).to eq([ 
        ["C", nil, nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil]] )
    end

    it "returns false if coordinates provided has already been used" do
      spot_occupied_board = Board.new([
        ["C", nil, nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil]] )
      expect(spot_occupied_board.add_to_board([0, 0], "C")).to be false
    end

    it "returns false if point chosen is not on the board" do
      expect(subject.add_to_board([10, 10], "C")).to be false
    end
  end

  describe "#within_valid_coordinates?" do
    it "displays error message if out of bounds" do
      expect do 
        subject.within_valid_coordinates?([10, 10])
      end.to output("The chosen coordinates are not in the range of the board\n").to_stdout
    end

    it "doesn't display error if coordinates are okay" do
      expect{subject.within_valid_coordinates?([1, 2])}.not_to output.to_stdout
    end
  end


  describe "#coordinates_available?" do
    let(:sparse_board) do 
      Board.new([ 
        ["C", nil, nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, "C", nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil] ] )
    end

    it "displays error message if spot is taken" do
      expect{sparse_board.coordinates_available?([0, 0])}.to output(
        "Position already used\n").to_stdout
    end

    it "doesn't display error message if spot is open" do
      expect{sparse_board.coordinates_available?([2, 2])}.not_to output(
        "Position already used!\n").to_stdout
    end
  end

   describe "#full?" do
    it "returns true for full board" do
      full_board = Board.new( [
        ["1", "C", "X", "F", "C", "C", "F", "2", "F", "1"],
        ["1", "C", "X", "F", "C", "C", "F", "2", "F", "1"],
        ["1", "C", "X", "F", "C", "C", "F", "2", "F", "1"],
        ["1", "C", "X", "F", "C", "C", "F", "2", "F", "1"],
        ["1", "C", "X", "F", "C", "C", "F", "2", "F", "1"],
        ["1", "C", "X", "F", "C", "C", "F", "2", "F", "1"],
        ["1", "C", "X", "F", "C", "C", "F", "2", "F", "1"],
        ["1", "C", "X", "F", "C", "C", "F", "2", "F", "1"],
        ["1", "C", "X", "F", "C", "C", "F", "2", "F", "1"],
        ["1", "C", "1", "F", "C", "C", "F", "2", "F", "1"]])
      expect(full_board.full?).to be true
    end

    it "returns false if board isn't full" do
      not_full_board = Board.new( [ 
        ["C", nil, nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, "C", nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil] ]  )
      expect(not_full_board.full?).to be false
    end

  end

   describe "ways to win" do
    it "returns true if the user has won i.e. a full board" do
      full_board = Board.new( [
        ["1", "C", "X", "F", "C", "C", "F", "2", "F", "1"],
        ["1", "C", "X", "F", "C", "C", "F", "2", "F", "1"],
        ["1", "C", "X", "F", "C", "C", "F", "2", "F", "1"],
        ["1", "C", "X", "F", "C", "C", "F", "2", "F", "1"],
        ["1", "C", "X", "F", "C", "C", "F", "2", "F", "1"],
        ["1", "C", "X", "F", "C", "C", "F", "2", "F", "1"],
        ["1", "C", "X", "F", "C", "C", "F", "2", "F", "1"],
        ["1", "C", "X", "F", "C", "C", "F", "2", "F", "1"],
        ["1", "C", "X", "F", "C", "C", "F", "2", "F", "1"],
        ["1", "C", "1", "F", "C", "C", "F", "2", "F", "1"]])
      expect(full_board.full?).to be true
    end
  end

   describe "add mines to board" do
    it "adds 9 mines to an empty board" do
      mines_board = Board.new 
      mines_board.add_mines_to_board(9)
      expect(mines_board.mine.mine_arr.size).to eq(9)
    end
  end


  # describe "#num_adj_mines" do
  #   it "returns the number of adjacent mines to a particular cell reference" do
  #     board_with_mines = Board.new( [
  #       ["1", "C", "X", "F", "C", "C", "F", "2", "F", "1"],
  #       ["1", "X", "X", "F", "C", "C", "F", "2", "F", "1"],
  #       ["1", "C", "X", "F", "C", "C", "F", "2", "F", "1"],
  #       ["1", "C", "X", "F", "C", "C", "F", "2", "F", "1"],
  #       ["1", "C", "X", "F", "C", "C", "F", "2", "F", "1"],
  #       ["1", "C", "X", "F", "C", "C", "F", "2", "F", "1"],
  #       ["1", "C", "X", "F", "C", "C", "F", "2", "F", "1"],
  #       ["1", "C", "X", "F", "C", "C", "F", "2", "F", "1"],
  #       ["1", "C", "X", "F", "C", "C", "F", "2", "F", "1"],
  #       ["1", "C", "1", "F", "C", "C", "F", "2", "F", "1"]])
  #     expect(board_with_mines.num_adj_mines([2,1])).to eq(2)


  #     puts "#{board_with_mines[[2][1]]}"
  #   end
  # end



    # describe "#update_clear_neighbours" do
    #   it "updates neighbouring automatically if there are no mines nearby" do
    #     auto_clear_board = Board.new( [
    #     ["C", nil, nil, nil, nil, nil, nil, nil, nil, nil],
    #     [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
    #     [nil, nil, "X", nil, nil, nil, nil, nil, nil, nil],
    #     [nil, nil, "X", nil, nil, nil, nil, nil, nil, nil],
    #     [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
    #     [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
    #     [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
    #     [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
    #     [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
    #     [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil] ]  )
    #     auto_clear_board.update_clear_neighbours([0,9])
    #     expect{auto_clear_board.render}.to output("\nC--------\n---------\n--X------\n--X------\n---------\n---------\n---------\n---------\n---------\n---------\n\n").to_stdout
    #   end

    # end
end