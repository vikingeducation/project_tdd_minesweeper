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
      expect{subject.render}.to output("\n----------\n----------\n----------\n----------\n----------\n----------\n----------\n----------\n----------\n----------\n----------\n\n").to_stdout
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

      expect{in_progress_board.render}.to output("\n1CXFCCF2F1\n1CXFCCF2F1\n1C-FCCF2F1\n1C-FCCF2F1\n1C-FCCF2F1\n1CXFCCF2F1\n1CXFCCF2F1\n1CXFCCF2F-\n1CXFCCF2F-\n1C1FCCF2F-\n\n").to_stdout
    end
  end

    describe "#add_marker" do 

    it "sets valid piece in place" do
    
      subject.add_marker([0, 0], "F")
      expect(subject.board).to eq([ ["X", nil, nil], 
                                        [nil, nil, nil], 
                                        [nil, nil, nil]] )
    end

    it "returns false if spot filled" do
      # Set up the subject instance with a piece in place
      not_full_board = Board.new( [ ["X", nil, nil], 
                                    [nil, nil, nil], 
                                    [nil, nil, nil]] )
      # Then try to put another piece in the same spot
      expect(not_full_board.add_marker([0, 0], "F")).to be false
    end

    it "returns false if spot is not on the board" do
      expect(subject.add_marker([10, 10], "X")).to be false
    end
  end

  describe "#within_valid_coordinates?" do
    it "displays error message if out of bounds" do
      expect do 
        subject.within_valid_coordinates?([10, 10])
      end.to output("Piece coordinates are out of bounds\n").to_stdout
    end

    it "doesn't display error if coordinates are okay" do
      expect{subject.within_valid_coordinates?([1, 2])}.not_to output.to_stdout
    end
  end


  describe "#coordinates_available?" do

    # Add some pieces to the board so there are unavailable spots
    let(:test_board) do 
      Board.new(  [ ["X", "O", "X"], 
                    [nil, nil, nil], 
                    [nil, nil, nil] ] )
    end

    it "displays error message if spot is taken" do
      expect{test_board.coordinates_available?([0, 0])}.to output(
        "There is already a piece there!\n").to_stdout
    end

    it "doesn't display error message if spot is open" do
      expect{test_board.coordinates_available?([2, 2])}.not_to output(
        "There is already a piece there!\n").to_stdout
    end
  end

   describe "#full?" do

    it "returns true for full board" do

      full_board = Board.new( [ ["X", "O", "X"], 
                                ["O", "X", "O"], 
                                ["X", "O", "X"] ] )
      expect(full_board.full?).to be true
    end

    it "returns false if board isn't full" do
      not_full_board = Board.new( [ ["X", "O", "X"], 
                                    [nil, nil, nil], 
                                    [nil, nil, nil] ] )
      expect(not_full_board.full?).to be false
    end

  end

   describe "ways to win" do

    it "returns true if the ser has won i.e a full board"

   end


end