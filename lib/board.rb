class Board

  attr_accessor :board

  def initialize(board=nil)
    @board = Array.new(9){Array.new(9)}
  end

end