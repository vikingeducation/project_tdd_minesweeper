require 'minesweeper'

describe Minesweeper do

  let (:minesweeper) { Minesweeper.new }

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

  describe '#place_flag' do





  end





end