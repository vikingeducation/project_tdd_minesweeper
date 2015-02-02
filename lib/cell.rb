
class Cell
  attr_accessor :mine, :hidden, :flagged, :adjacent_mines
  def initialize(mine=false, hidden=true, flagged=false, adjacent_mines=0)
    @mine = mine
    @hidden = hidden
    @flagged = flagged
    @adjacent_mines = adjacent_mines
  end

  def symbolize
    if (@flagged)
      return "⚑"
    elsif(@hidden)
      return "■"
    elsif(@mine)
      return "✷"
    elsif(@adjacent_mines == 0)
      return "□"
    elsif(@adjacent_mines)
      return @adjacent_mines.to_s
    end
  end
end