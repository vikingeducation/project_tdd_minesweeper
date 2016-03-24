class Cell
  attr_accessor :state, :reveal, :flag, :is_bomb
  def initialize
    @state = 0
    @flag = false
    @reveal = false
    @is_bomb = false
  end
end