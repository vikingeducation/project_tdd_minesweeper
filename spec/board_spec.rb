require 'board'

describe Board do

  describe "#initialize" do

    it "creates (Height * Width) new Squares" do
      expect(Square).to receive(:new).exactly(100).times
      Board.new
    end

    it "passes x,y coordinates to squares" do
      expect(Square).to receive(:new).with(1,1)
      expect(Square).to receive(:new).with(1,2)
      expect(Square).to receive(:new).with(2,1)
      expect(Square).to receive(:new).with(2,2)
      Board.new(2, 2, 1)
    end

    it "starts with victory and defeat conditions as false" do
      fresh_board = Board.new
      expect(fresh_board.victory).to be_falsey
      expect(fresh_board.defeat).to be_falsey
    end

  end


  describe "#row_status" do
    let(:board) { Board.new }

    it "outputs an array" do
      expect(board.row_status(3)).to be_an(Array)
    end

    it "makes output array the same size as the width of the board" do
      expect(board.row_status(3).size).to eq(10)
    end

    it "displays the square's status in the array" do
      small_board = Board.new(3,3,1)
      expect(small_board.row_status(3)).to eq(["#","#","#"])
    end

  end


  describe "#render_column_header" do
    let(:board) { Board.new }

    it "prints sequential letters" do
      expect{ board.render_column_header }.to output(/\A[A]\s[B]\s[C].*\n\z/).to_stdout
    end

    it "prints out 10 letters by default" do
      expect(subject).to receive(:render_row).with(%w(A B C D E F G H I J))
      subject.render_column_header
    end

    it "prints out number of letters to match board width" do
      small_board = Board.new(6,6,3)
      expect(small_board).to receive(:render_row).with(%w(A B C D E F))
      small_board.render_column_header
    end

  end



  describe "#place_mines" do
    let(:square) { double(:plant_mine => true) }

    before do
      allow(Square).to receive(:new).and_return(square)
    end

    it "should call #plant_mine on each square" do
      expect(square).to receive(:plant_mine)
      subject.place_mines
    end

  end


  describe "#run_nearby_mines" do
    let(:square) { double(:count_nearby_mines => true) }

    before do
      allow(Square).to receive(:new).and_return(square)
    end

    xit "should call #count_nearby_mines" do
      expect(square).to receive(:count_nearby_mines)
      subject.run_nearby_mines
    end

  end


  describe "#count_nearby_mines" do
    let(:square) { double(:x => 3, :y => 2) }

    before do
      allow(Square).to receive(:new).and_return(square)
    end

    it "returns a number" do
      expect(subject.count_nearby_mines(square)).to be_a(Fixnum)
    end

    xit "counts all nearby mines" do
      square_1_1 = double(:x => 1, :y =>1, :mine => true)
      square_1_2 = double(:x => 1, :y =>2, :mine => true)
      square_1_3 = double(:x => 1, :y =>3, :mine => true)
      square_2_1 = double(:x => 2, :y =>1, :mine => true)
      square_2_2 = double(:x => 2, :y =>2, :mine => true)
      square_2_3 = double(:x => 2, :y =>3, :mine => true)
      square_3_1 = double(:x => 3, :y =>1, :mine => true)
      square_3_2 = double(:x => 3, :y =>2, :mine => true)
      square_3_3 = double(:x => 3, :y =>3, :mine => true)

      squares = [square_1_1, square_1_2, square_1_3,
                 square_2_1, square_2_2, square_2_3,
                 square_3_1, square_3_2, square_3_3]

      expect(subject.count_nearby_mines(square_2_2)).to eq(9)
    end

    xit "accepts a Square class as the only argument" do
      expect(subject).to receive(:count_nearby_mines).with(Square)
      subject.count_nearby_mines(square)
    end

    xit "rejects non-Square class arguments"

    xit "finds other squares with x and/or y +/- 1" do
      expect(subject.count_nearby_mines(square)).to 
    end

    it "doesn't try to find out of range squares"

    it "counts flags with mines underneath"

    it "doesn't count flags without mines underneath"

  end


  describe "#nearby_square?" do
    let(:current) { double(:x => 3, :y => 5) }
    let(:other) { double(:x => 1, :y => 1) }

    it "returns true for a square that's +1, +1 away" do
      allow(other).to receive(:x).and_return(4)
      allow(other).to receive(:y).and_return(6)
      expect(subject.nearby_square?(current, other)).to be_truthy
    end

    it "returns true for a square that's -1, -1 away" do
      allow(other).to receive(:x).and_return(2)
      allow(other).to receive(:y).and_return(4)
      expect(subject.nearby_square?(current, other)).to be_truthy
    end

    it "returns true for a square that's -1, 0 away" do
      allow(other).to receive(:x).and_return(2)
      allow(other).to receive(:y).and_return(5)
      expect(subject.nearby_square?(current, other)).to be_truthy
    end

    it "returns false for a square that's +2, 0 away" do
      allow(other).to receive(:x).and_return(5)
      allow(other).to receive(:y).and_return(5)
      expect(subject.nearby_square?(current, other)).to be_falsey
    end

    it "returns false for a square that's 0, -2 away" do
      allow(other).to receive(:x).and_return(3)
      allow(other).to receive(:y).and_return(3)
      expect(subject.nearby_square?(current, other)).to be_falsey
    end

  end

  describe "#count_flags" do
    let(:square) { double(:status => "X") }

    it "should count squares where status is flagged" do
      b = Board.new(2,2,1)
      squares = [square, square, square, square]
      expect(b.count_flags(squares)).to eq(4)
    end

  end


  describe "#process" do
    let(:board) { Board.new }
    let(:square) { double(:x => 3, :y => 2, :cleared => false) }

    before do
      allow(Square).to receive(:new).and_return(square)
      allow(subject).to receive(:feedback).and_return(true)
      allow(subject).to receive(:count_flags).and_return(0)
    end

    it "finds the target square by row and column" do
      move = {command: "clear", row: 2, column: 3}
      allow(square).to receive(:clear)
      expect(square.x).to eq(3)
      expect(square.y).to eq(2)
      subject.process(move)
    end

    it "calls #clear on target square when commanded" do
      move = {command: "clear", row: 2, column: 3}
      expect(square).to receive(:clear)
      subject.process(move)
    end

    it "calls #flag on target square when commanded" do
      move = {command: "flag", row: 2, column: 3}
      expect(square).to receive(:flag)
      subject.process(move)
    end

    it "calls #feedback to see if a mine is hit" do
      move = {command: "clear", row: 2, column: 3}
      allow(square).to receive(:clear).and_return(true)
      expect(subject).to receive(:feedback)
      subject.process(move)
    end

    it "will not add a flag if zero flags remaining" do
      move = {command: "flag", row: 2, column: 3}
      allow(subject).to receive(:count_flags).and_return(9)
      expect(square).not_to receive(:flag)
      subject.process(move)
    end

    it "allows player to unflag if zero flags remaining" do
      move = {command: "unflag", row: 2, column: 3}
      allow(square).to receive(:cleared).and_return(true)
      allow(subject).to receive(:count_flags).and_return(9)
      expect(square).to receive(:unflag)
      subject.process(move)
    end

    it "should not be able to flag a cleared space" do

    end

    #change cleared/flagged variables on square
    #keeps cleared squares as cleared
    #removes flag if already flagged
    #booms if mine

  end


  describe "#feedback" do
    let(:target) { double(:mine => true) }

    it "ends the game if a mine square was cleared" do
      move = {command: "clear"}
      #allow(target).to receive(:mine).and_return(true)
      allow(subject).to receive(:autoclear).and_return(true)
      expect{subject.feedback(target, move)}.to change{subject.defeat}.from(false).to(true)
    end


    it "declares victory if all squares are cleared" do
      move = {command: "clear"}
      allow(subject).to receive(:all_cleared?).and_return(true)
      expect{subject.feedback(target, move)}.to change{subject.victory}.from(false).to(true)
    end


    it "returns false if at least 1 square is not clear"

  end


  describe "#autoclear" do



  end

end