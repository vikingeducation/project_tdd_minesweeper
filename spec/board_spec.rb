require "board"

describe Board do 

  let(:board){ Board.new }

  describe "#initialize" do 
    it "should create a 10 X 10 square saved to an instance variable" do 
      expect(board.grid).to eq(Array.new(10) { Array.new(10) })
    end

    it "should start with 9 mines by default" do 
      expect(board.mines).to eq(9)
    end

    it "should show remaining flags" do 
      expect(board.remaining_flags).to eq(9)
    end
  end

  describe "#set_mines" do 
    it "makes sure that two or more bombs do not share the same coordinates" do 
      board.set_mines(1,2)
      expect(board.mine_array.length).to eq(10)
    end

    it "sets the instance variable mine array to 10 nested arrays of row and column coordinates" do 
      board.set_mines(1, 2)
      expect(board.mine_array.length).to eq(10)
    end

    it "does not return an array that contains the first move coordinates" do
      board.instance_variable_set(:@mine_array, [[1, 2]])
      board.set_mines(1, 2)
      expect(board.mine_array.include?([1, 2])).to be false
    end 
  end

  describe "#open_square" do
    it "places the :O marker on the grid given player's coordinates" do 
      board.open_square(1, 2)
      expect(board.grid[1][2]).to eq(:O)
    end

    it "places the :O marker on the grid coordinates 3,4" do
      board.open_square(3, 4)
      expect(board.grid[3][4]).to eq(:O)
    end

    it "places a 1 on the grid of coordinates 2,3 if there are 1 adjacent mine" do 
      board.instance_variable_set(:@mine_array, [[1, 2], [0, 9]])
      board.open_square(2, 3)
      expect(board.grid[2][3]).to eq(1)
    end

    it "places a 2 on the grid of coordinates 2,3 if there are 2 adjacent mines" do 
      board.instance_variable_set(:@mine_array, [[1, 2], [1, 3]])
      board.open_square(2, 3)
      expect(board.grid[2][3]).to eq(2)
    end

    it "decreases remaining squares by 1" do 
      board.open_square(3, 4)
      expect(board.remaining_squares).to eq(90)
    end
  end

  describe "#set_flag" do 
    it "should mark a square ':F'" do 
      board.set_flag(1, 2)
      expect(board.grid[1][2]).to eq(:F)     
    end

    it "decreases the number of flags by 1 if flag is placed on board" do 
      board.set_flag(1, 2)
      expect(board.remaining_flags).to eq(8)
    end
   end

  describe "#valid_square?" do 
    it "returns true if square is nil" do 
      expect(board.valid_square?(1, 2)).to be true
    end

    it "returns false if square is not nil" do
      board.grid[0][0] = :O
      expect(board.valid_square?(0, 0)).to be false
    end
  end
  describe "#contains_mine?" do 
    it "returns false if player coordinates contains a mine" do 
      board.instance_variable_set(:@mine_array, [[1, 2]])
      expect(board.contains_mine?(1, 2)).to be true
    end

    it "returns false if player coordinates do not contain a mine" do
      board.instance_variable_set(:@mine_array, [[2, 3]])
      expect(board.contains_mine?(1, 2)).to be false
    end
  end

  describe "#adjacent_squares" do 
    it "should return an array with the 8 adjacent square coordinates if selected square is not at the edge of board" do
      expect((board.adjacent_squares(2, 3) - [[1, 2], [1, 3], [1, 4], [2, 4], [3, 4], [3, 3], [3, 2], [2, 2]]).length).to eq(0)
    end

    it "should return an array with 3 coordinates even if move coordinates are at corner" do 
      expect((board.adjacent_squares(0, 0)).length).to eq(3)
    end

    it "should return an array with 3 coordinates if selected square is the top right corner" do 
      expect((board.adjacent_squares(0, 9)).length).to eq(3)
    end
  end

  describe "#mine_count" do 
    it "returns 1 for number of mines in neighboring squares if they contain a mine" do 
      board.instance_variable_set(:@mine_array, [[1, 2], [0, 9]])
      expect(board.mine_count(2, 3)).to eq(1)
    end

    it "returns 0 for number of mines in neighboring squares if they don't contain any mines" do 
      board.instance_variable_set(:@mine_array, [[0, 9], [8, 0]])
      expect(board.mine_count(2, 3)).to eq(0)
    end

    it "returns 1 for number of mines for a corner square if adjacent square contains a mine" do 
      board.instance_variable_set(:@mine_array, [[1, 2], [0, 1]])
      expect(board.mine_count(0, 0)).to eq(1)
    end

    it "returns 2 for number of mines if adjacent squares contain 2 mines" do 
      board.instance_variable_set(:@mine_array, [[1, 0], [0, 1]])
      expect(board.mine_count(0, 0)).to eq(2)
    end
  end

  describe "#win?" do 
    it "returns true when remaining squares is 0" do
      board.instance_variable_set(:@remaining_squares, 0)
      expect(board.win?).to be true
    end

    it "returns false when remaining squares is not 0" do 
      expect(board.win?).to be false
    end    
  end

  describe "#auto_clear" do 
    it "returns 3 if there selected square is a corner with :O marker and no mines adjacent to it" do 
      board.grid[0][0] = :O
      expect(board.auto_clear(0, 0).length).to eq(3)
    end

    it "returns 8 if selected square is not a corner with :O marker and no mines adjacent to it" do 
      board.grid[1][2] = :O
      expect(board.auto_clear(1, 2).length).to eq(8)
    end

    it "returns nil if selected square's marker is not :O" do 
      board.grid[1][2] = :F
      expect(board.auto_clear(1, 2)).to eq(nil)
    end
  end

end
















