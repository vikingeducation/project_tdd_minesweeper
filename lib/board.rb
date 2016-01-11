class Board
  ROWS = 10
  COLUMNS = 10
  MINES = 10
  attr_accessor :board, :mines

  def initialize
    @board = []
    @mines = []
    ROWS.times do
      @board.push(Array.new(COLUMNS, "-"))
    end
    place_mines(MINES)
  end

  def place_mines(mines)
    return true if mines <= 0
    row = (0..ROWS-1).to_a.sample
    column = (0..COLUMNS-1).to_a.sample
    unless @mines.include?([row, column])
      @mines << [row, column]
    end
    place_mines(mines-1)
  end
end