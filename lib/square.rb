class Square
  attr_reader :x, :y, :cleared, :flagged

  def initialize(x, y)
    @x = x
    @y = y
    @mine = @cleared = @flagged = false
  end


  def plant_mine
    @mine = true
  end


  def flag
    @flagged = !@flagged
  end


  def clear
    @cleared = true # once clear, always clear
  end


  def status
    status = "#" if !@cleared && !@flagged
    status = "X" if !@cleared && @flagged
    status = " " if @cleared

    status
  end

end