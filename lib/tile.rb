class Tile
  attr_accessor :x, :y, :mine, :revealed

  def initialize(x, y, mine = false)
    @x        = x
    @y        = y
    @mine     = mine
    @revealed = false
  end

  def click
    @revealed = true
  end
end
