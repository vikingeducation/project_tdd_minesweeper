# rspec/mine_spec.rb

require 'mine'

describe Mine do

  let(:mine_obj) {Mine.new }

   describe "#initialize" do
    it "creates a Mine of type Mine" do
      expect(Mine.new).is_a? Mine
    end
  end


  describe "#generate_coords" do
    let(:coords) {subject.generate_coords}

    it "creates a random x coordinate for a mine" do
      expect(coords[0]).to be_between(0,9).inclusive
    end

    it "creates a random y coordinate for a mine" do
      expect(coords[1]).to be_between(0,9).inclusive
    end
  end

  describe "#mine_created?" do
    let(:mine_obj) {Mine.new }

    before do
      mine_obj.mines = [[0,2], [0,3], [3,1]]
    end

    it "returns false if the new coordinates generated for a mine is not already created " do
      
      expect(mine_obj.mine_created?([0,1])).to be false
    end

    it "returns true if the new coordinates generated for a mine is created " do
      expect(mine_obj.mine_created?([0,3])).to be true
    end
  end

  describe "#isAdjacent?" do
    
    before do
      mine_obj.mines = [[0,2], [0,6], [3,1]]
    end

    it "returns true if a particular mine is adjacent to the cell reference provided" do
      expect(mine_obj.isAdjacent?([0,1], mine_obj.mines[0])).to be true
    end

    it "returns false if a mine is adjacent to the cell reference provided" do
      expect(mine_obj.isAdjacent?([0,4], mine_obj.mines[0])).to be false
    end
  end

  describe "#getNumberAdjacentMines?" do
    before do
      mine_obj.mines = [[0,2], [1,3], [0,6], [3,1]]
    end

    it "returns number of adjacent mines if there is a mine nearby" do
      expect(mine_obj.getNumberAdjacentMines([0,3])).to be(2) 
    end

    it "returns zero if no mines are adjacent to the cell reference provided" do
      expect(mine_obj.getNumberAdjacentMines([0,8])).to be(0)
    end
  end

  describe "#update_adj_clear_cells" do
  end

  # describe "create_mines" do
  #   it "Returns an array of size 9 for each of the random coordinates of mines to place on the board" do
  #     mine_obj.create_mines(9)

  #     mine_obj.mines.each do |x|
  #       x.none? {|y| y.nil?}
  #     end
  #     expect(mine_obj.mines.size).to be(9)
  #   end
  # end
end