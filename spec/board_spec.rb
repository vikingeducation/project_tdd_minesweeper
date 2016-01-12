require 'board'
require 'spec_helper'

describe Board do

  let(:board) { Board.new }
  let(:test_board) { Board.new( grid: [[Tile.new(mine:true),Tile.new,Tile.new],
                          [Tile.new,Tile.new,Tile.new],
                          [Tile.new,Tile.new,Tile.new]], size: 3) }

  describe "#initialize" do
    it "creates a 10x10 board by default" do
      expect(board.grid.size).to eq 10
    end

    it "creates a board the size passed" do
      expect(Board.new(size: 20).grid.size).to eq 20
    end

    it "starts with 9 mines by default" do
      expect(board.mines).to eq 9
    end

    it "can have a different number of mines" do
      expect(Board.new(mines: 20).mines).to eq 20
    end

    it "should have the same number of flags as mines" do
      expect(board.flags).to eq(board.mines)
    end
  end

  describe "#populate_tiles" do
    it "initializes all tiles" do
      board.populate_tiles
      board.grid.each do |row|
        row.each do |tile|
          expect(tile).to be_a(Tile)
        end
      end
    end
  end

  describe "#populate_board" do
    it "calls place_mine 9 times by default" do
      expect(board).to receive(:place_mine).exactly(9).times
      board.populate_board([0,4])
    end

    it "actually has 9 mines by default" do
      board.populate_board([1,2])
      num_mines = 0
      board.grid.each do |row|
        row.each do |tile|
          num_mines += 1 unless tile.safe?
        end
      end
      expect(num_mines).to eq(9)
    end

    it "sets the given coord to safe" do
      board.populate_board([1,2])
      expect(board.grid[1][2]).to be_safe
    end
  end

  describe "#place_mine" do
    it 'places a mine at the given coordinate' do
      tile_double = instance_double('Tile')
      expect(tile_double).to receive(:mine!)
      board.grid[1][4] = tile_double
      board.place_mine([1,4])
    end
  end

  describe '#check_neighbors' do

    it "checks each neighbor cell for mine" do
      test_board.check_neighbors
      expect(test_board.grid[1][1].unsafe_neighbors).to eq(1)
    end

  end
end
