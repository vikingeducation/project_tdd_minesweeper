class Tile

  attr_accessor :mine

  def initialize(mine = false)
    @mine = mine
  end

  def inspect
    @mine ? "M" : "0"
  end
end

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

