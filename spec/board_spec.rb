require_relative "../lib/board.rb"
require_relative "../lib/tile.rb"

describe Board do

  describe "#initialize" do

    it "is an instance of board class" do

      expect(subject).to be_a(Board)

    end

    it "creates a board of height * width" do

      expect(subject.game_state.flatten.length).to eq(subject.height * subject.width)

    end

  end

  describe "#clear nearby" do



  end


  describe "#find_direct_neighbors" do


    it "returns an array of 4 items for a middle tile" do

      my_tile = subject.game_state[3][3]
      expect(subject.find_direct_neighbors(my_tile)).to be_a(Array)
      expect(subject.find_direct_neighbors(my_tile).length).to eq(4)

    end

    it "returns an array of 2 items for a corner tile" do

      my_tile = subject.game_state[0][0]
      expect(subject.find_direct_neighbors(my_tile)).to be_a(Array)
      expect(subject.find_direct_neighbors(my_tile).length).to eq(2)

    end

    it "returns an array with only tiles" do

      my_tile = subject.game_state[3][3]
      expect(subject.find_direct_neighbors(my_tile)[0]).to be_a(Tile)

    end

  end

  describe "#generate_mines" do

    it "creates number of mines equal to the amount needed" do

      expect(subject.generate_mines(9)).to eq(9)

    end

    it "creates different mines" 

    # allow(Float).to receive(:rand).and_return(2)


  end

  describe "#get_tiles_mine_count" do


  end

end