class Cell 
  attr_accessor :mine, :flag, :clear, :show, :adjacent_mines

  def initialize
    @show = '*'
    @mine = false
    @flag = false
    @clear = false
    @adjacent_mines = 0
  end

  def set_mine
    self.mine = true
    self.show = 'B'
  end

  def set_flag
    self.flag = true
    self.show = 'F'
  end

  def unflag
    self.flag = false
    self.show = '*'
  end

  def clear_cell
    self.clear = true
  end
end