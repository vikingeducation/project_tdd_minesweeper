require 'minesweeper'

describe Minesweeper do

  let (:minesweeper) { Minesweeper.new }
  let(:minesweeper_custom) do
    custom = Minesweeper.new
    custom.grid.import_grid(
      [
        [" ", " ", " ", " ", "*", " ", " ", " ", " "], 
        ["*", " ", " ", " ", "*", " ", " ", " ", " "], 
        [" ", "*", " ", " ", " ", " ", " ", " ", " "], 
        ["*", " ", " ", " ", " ", " ", " ", " ", "*"], 
        [" ", " ", " ", " ", " ", " ", " ", " ", "*"], 
        [" ", " ", " ", " ", "*", " ", " ", " ", " "], 
        [" ", " ", " ", " ", " ", "*", " ", " ", " "], 
        [" ", " ", " ", " ", " ", " ", " ", " ", " "], 
        [" ", " ", " ", "*", " ", " ", " ", " ", " "]
      ] 
    )
    custom
    end


  describe "#initialize" do
    it "initializes grid and builds mines_hash" do
      expect(minesweeper.grid).to be_a(Grid)
      expect(minesweeper.grid.mines_hash.length).to eq(10)
    end

    it "places bombs into grid" do
      bombs = 0
      minesweeper.grid.grid.each do |row|
        row.each do |square|
          bombs += 1 if square.has_bomb
        end
      end
      expect(bombs).to eq (10)
    end

  end


  describe '#reveal_one_square' do
    it "switches square from revealed=false to revealed=true" do
      x, y = 3, 4
      expect(minesweeper.grid.grid[x][y].revealed).to be false
      minesweeper.reveal_one_square(x,y)
      expect(minesweeper.grid.grid[x][y].revealed).to be true
    end
  end

  describe '#user_flags_square' do
    it "switches square from flagged=false to flagged=true" do
      x, y = 3, 4
      expect(minesweeper.grid.grid[x][y].flagged).to be false
      minesweeper.user_flags_square(x,y)
      expect(minesweeper.grid.grid[x][y].flagged).to be true
    end
  end

  describe '#auto_reveal_multi_square' do
    it 'reveals squares until it hits bombs' do
      expect(minesweeper_custom.grid.grid[6][7].revealed).to be false
      minesweeper_custom.auto_reveal_multi_square(8,8)
      expect(minesweeper_custom.grid.grid[6][7].revealed).to be true
    end

  end

  describe '#user_reveal_multi_square' do
    it 'ends game if flags incorrect' do
      expect(minesweeper_custom.grid.grid[7][3].revealed).to be false
      expect(minesweeper_custom.grid.grid[7][4].revealed).to be false

      minesweeper_custom.grid.place_flag( 5, 4 ) 
      minesweeper_custom.grid.place_flag( 6, 5 ) 
      minesweeper_custom.user_reveal_multi_square(6, 4)

      expect(minesweeper_custom.grid.grid[7][3].revealed).to be true
      expect(minesweeper_custom.grid.grid[7][4].revealed).to be true
    end
  end

  describe '#play' do
    it "verifies reveal one square play path" do
        expect(minesweeper_custom.grid.grid[3][5].revealed).to be false
        allow(minesweeper).to receive(:gets).and_return("1", "3,5")
        minesweeper.play
        # puts minesweeper_custom.grid.grid[3][5].revealed
        expect(minesweeper_custom.grid.grid[3][5].revealed).to be true
    end
  end

end