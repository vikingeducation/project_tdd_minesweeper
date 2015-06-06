class Square
  attr_reader :x, :y, :mine, :cleared, :flagged
  attr_accessor :nearby_count

  def initialize(x, y)
    @x = x
    @y = y
    @mine = @cleared = @flagged = @clue = false
  end


  def plant_mine
    @mine = true
  end


  def flag
    @flagged = !@flagged
  end


  def clear
    @cleared = true # once clear, always clear
    @clue = true if @nearby_count != 0
  end


  def status
    status = "#" if !@cleared && !@flagged
    status = "X" if !@cleared && @flagged
    status = " " if @cleared && !@mine
    status = self.nearby_count if @clue
    status = "*" if @cleared && @mine

    status = "m" if !@cleared && @mine #testing only

    status
  end

end