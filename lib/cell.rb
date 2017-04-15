class Cell
  attr_accessor :bomb, :flag, :cover, :adjacent_bombs
  def initialize
    @bomb = false
    @flag = false
    @cover = true
    @adjacent_bombs = 0
  end

  def render
    return '|' if @flag
    return '#' if @cover
    return 'X' if @bomb
    adjacent_bombs > 0 ? adjacent_bombs.to_s : '_'
  end

  def toggle_cover
    return false if @flag
    @cover = false
    return true if @bomb
  end

  def toggle_flag
    return false unless @cover
    @flag = @flag ? false : true
  end
end
