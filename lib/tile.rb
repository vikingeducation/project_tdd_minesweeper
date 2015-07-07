class Tile

  attr_accessor :is_mine, :is_flag, :is_cleared, :mines_nearby
  attr_reader :x, :y

  def initialize(x, y)

    @x = x
    @y = y
    @is_mine = false
    @is_flag = false
    @is_cleared = false
    @mines_nearby = 0

  end

end