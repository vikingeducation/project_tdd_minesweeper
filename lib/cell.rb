class Cell
  attr_accessor :bomb, :flag, :cover, :adjacent_bombs
  def initialize
    @bomb = false
    @flag = false
    @cover = true
    @adjacent_bombs = nil
  end

  def render
    return '|' if @flag
    return 'O' if @cover
    return 'X' if @bomb
    adjacent_bombs ? adjacent_bombs.to_s : '_'
  end
end
