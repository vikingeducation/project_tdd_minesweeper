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


  describe "#count_flags" do
    let(:square) { double(:status => "@") }

    it "should count squares where status is flagged" do
      b = Board.new(2,2,1)
      squares = [square, square, square, square]
      expect(b.count_flags(squares)).to eq(4)
    end

  end


  describe "#process" do
    let(:board) { Board.new }
    let(:square) { double(:x => 3, :y => 2) }

    before do
      allow(Square).to receive(:new).and_return(square)
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
      expect{subject.feedback(target, move)}.to change{subject.defeat}.from(false).to(true)
    end

  end



  describe "#flag" do

  end

end