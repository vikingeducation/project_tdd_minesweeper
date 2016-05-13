class Tile
  attr_accessor :x, :y, :mine, :neighboring_mines

  def initialize(x,y)
    @x, @y = x, y
    @mine = false
    @neighboring_mines = 0
  end
end
