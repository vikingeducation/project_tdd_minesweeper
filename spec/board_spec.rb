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
      expect(small_board.row_status(3)).to eq(["O","O","O"])
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

    it "should count squares where status is flagged" do
      b = Board.new(2,2,1)
      square = double
      allow(square).to receive(:status).and_return("@")
      squares = [square, square, square, square]
      expect(b.count_flags(squares)).to eq(4)
    end

  end


  describe "#process" do



  end

end