require_relative 'tile'

class Board
  attr_reader :grid, :mines, :flags

  def initialize(size: 10, mines: 9, grid: nil)
    @size = size
    @grid = grid || Array.new(size) { Array.new(size) }
    @mines = mines
    @flags = mines
  end

  def populate_board(given_coord)
    unplaced_mines = @mines
    until unplaced_mines == 0
      coord = random_coord
      next if coord == given_coord
      place_mine(coord)
      unplaced_mines -= 1
    end
  end

  def move(coord)
    tile_at(coord).reveal!

    return true unless tile_at(coord).safe?
    false
  end

  def place_mine(coord)
    tile = tile_at(coord)
    tile.mine!
  end

  def check_neighbors
    @grid.each_with_index do |row, y|
      row.each_with_index do |tile, x|
        check_neighbor(y,x) if @grid[y][x].safe?
      end
    end
  end

  def check_neighbor(y,x)
    possible_neighbors = [[y-1,x-1],[y-1,x],[y,x-1],[y-1,x+1],[y,x+1],[y+1,x],[y+1,x+1],[y+1,x-1]]
    bad_neighbors = 0
    possible_neighbors.each do |coord|
      if tile_exists?(coord)
        neighbor = @grid[coord[0]][coord[1]]
        bad_neighbors += 1 unless neighbor.safe?
      end
    end
    @grid[y][x].unsafe_neighbors = bad_neighbors
  end

  def tile_exists?(tile_coord)
    y = tile_coord[0]
    x = tile_coord[1]
    y >= 0 && y < @size && x >= 0 && x < @size
  end

  private

  def tile_at(coord)
    x, y = coord
    @grid[x][y]
  end

  def random_coord
    x = (0...@size).to_a.sample
    y = (0...@size).to_a.sample
    [x,y]
  end
end
