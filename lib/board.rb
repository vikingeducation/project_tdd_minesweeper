class Board
  ROWS = 10
  COLUMNS = 10
  MINES = 10
  attr_accessor :board

  def initialize
    @board = []
    ROWS.times do
      @board.push(Array.new(COLUMNS, "-"))
    end
  end
end