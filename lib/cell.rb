class Cell 
  attr_accessor :mine, :flag, :clear

  def initialize
    @mine = false
    @flag = false
    @clear = false
  end

  def set_mine
    self.mine = true
  end

  def set_flag
    self.flag = true
  end

  def clear_cell
    self.clear = true
  end
end