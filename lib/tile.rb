class Tile
  attr_accessor :x, :y, :mine, :neighboring_mines, :hidden, :flag

  def initialize(x,y)
    @x, @y = x, y
    @mine = false
    @neighboring_mines = 0
    @hidden = true
    @flag = false
  end
end
