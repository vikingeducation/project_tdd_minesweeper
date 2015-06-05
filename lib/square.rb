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
    @cleared = !@cleared
  end


  def status
    status = "O" if !@cleared && !@flagged
    status = "@" if !@cleared && @flagged
    status = "_" if @cleared

    status
  end

end