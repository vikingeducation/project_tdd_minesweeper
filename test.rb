class Tile

  attr_accessor :mine

  def initialize(mine = false)
    @mine = mine
  end

  def place_mine
    @mine = true
  end

  def inspect
    @mine ? "M" : "0"
  end
end

class Board

  NEIGHBOR_COORDS = [
    [0,1],
    [1,1],
    [1,0],
    [1,-1],
    [0,-1],
    [-1,-1],
    [-1,0],
    [-1,1]
  ]

  def initialize
    @data = Array.new(10) { Array.new(10) { Tile.new } }
  end

  def neighbors_for_coord(x,y)
    NEIGHBOR_COORDS.map do |xdiff, ydiff|
      # [xdiff + x, ydiff + y]
      neighbor_x = xdiff + x
      neighbor_y = ydiff + y
      self[neighbor_x, neighbor_y]
    end
  end

  def [](x, y)
    @data[y][x]
  end
end

b = Board.new

b[1, 3].place_mine # => true
b[1, 3] # => M
b[2, 3].place_mine # => true
b[1, 2].place_mine # => true

b.neighbors_for_coord(1, 3) # => [0, 0, M, 0, M, 0, 0, 0]

@array_of_tiles = Array.new(10) { Array.new(10) { Tile.new } }

my_tile = Tile.new(true)

@array_of_tiles[4][2] = my_tile

def coords_for_tile(given_tile)
  @array_of_tiles.each_with_index do |row, x|
    row.each_with_index do |tile, y|
      return [x, y] if tile == given_tile
    end
  end
  false
end

coords_for_tile(my_tile) # => [4, 2]

