require "colorize"

class Cell 
  attr_accessor :mine, :flag, :clear, :show, :adjacent_mines

  def initialize
    @show = '*'.colorize(:light_blue)
    @mine = false
    @flag = false
    @clear = false
    @adjacent_mines = 0
  end

  def set_mine
    self.mine = true
  end

  def set_flag
    self.flag = true
    self.show = 'F'.colorize(:light_green)
  end

  def unflag
    self.flag = false
    self.show = '*'.colorize(:light_blue)
  end

  def clear_cell
    self.clear = true
  end
end