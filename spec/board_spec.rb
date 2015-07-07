require_relative "../lib/board.rb"
require_relative "../lib/tile.rb"

describe Board do

  describe "#initialize" do

    it "is an instance of board class" do

      expect(subject).to be_a(Board)

    end

    it "creates a board of height * width (#create_board method implicit)" do

      expect(subject.game_state.flatten.length).to eq(subject.height * subject.width)

    end

  end

  describe "#clear nearby" do

    let(:no_mine_board) {Board.new(10,10,0)}

    it "clears the tile next to it if there are no mines in this tile" do

      my_tile = no_mine_board.game_state[2][2]
      my_nearby_tile = no_mine_board.game_state[2][3]
      no_mine_board.clear_nearby(my_tile)
      expect(my_nearby_tile.is_cleared).to be true

    end

    it "clears a far away tile if it's in the pattern line" do

      my_tile = no_mine_board.game_state[2][2]
      my_faraway_tile = no_mine_board.game_state[9][9]
      no_mine_board.clear_nearby(my_tile)
      expect(my_faraway_tile.is_cleared).to be true

    end

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

    it "creates different mines" do


    end


  end

  describe "#get_tiles_mine_count" do

    it "finds nearby mines for every tile" do

      expect(subject).to receive(:find_mines_nearby).exactly(100).times
      subject.get_tiles_mine_count

    end

  end

  describe "#find_mines_nearby" do

    it "finds nearby mines for a specific tile" do

      my_tile = subject.game_state[3][5]
      my_nearby_mine = subject.game_state[3][6]
      my_nearby_mine.is_mine = true
      subject.find_mines_nearby(my_tile)

      expect(my_tile.mines_nearby).to be >= 1

    end

    it "finds 8 mines if all neighbors are mines" do

      my_tile = subject.game_state[2][2]
      (1..3).each do |x|
        (1..3).each do |y|
          subject.game_state[x][y].is_mine = true unless x == 2 && y == 2
        end
      end

      subject.find_mines_nearby(my_tile)
      expect(my_tile.mines_nearby).to eq(8)

    end

  end

  describe "#find_neighbors" do

    it "finds a max of 8 neigbors" do

      my_tile = subject.game_state[3][3]
      expect(subject.find_neighbors(my_tile)).to be_a(Array)
      expect(subject.find_neighbors(my_tile).length).to eq(8)

    end

    it "finds 3 neigbors for a corner tile" do

      my_tile = subject.game_state[0][0]
      expect(subject.find_neighbors(my_tile)).to be_a(Array)
      expect(subject.find_neighbors(my_tile).length).to eq(3)

    end

    it "finds 5 neigbors for a side tile" do

      my_tile = subject.game_state[0][5]
      expect(subject.find_neighbors(my_tile)).to be_a(Array)
      expect(subject.find_neighbors(my_tile).length).to eq(5)

    end

  end

end