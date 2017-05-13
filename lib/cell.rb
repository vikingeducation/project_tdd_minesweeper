# Cell
class Cell
  attr_accessor :near_mines
  attr_reader :mine, :marked, :cleared
  #initializes a blank cell
  def initialize
    @mine = false
    @marked = false
    @cleared = false
    @near_mines = 0
  end

  def plant_mine
    @mine = true
  end

  def mark_mine
    @marked = true
  end

  def unmark_mine
    @marked = false
  end

  def clear
    @cleared = true
  end

end
