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
    place_mines(MINES)
  end

  def place_mines(mines)
    return false if mines > ROWS * COLUMNS
    counter = 0
    mines.times do 
      row = board.sample
      column = row.sample
      if column == "-"
        column = "X"
        counter += 1
      else
        place_mines(mines - counter)
      end
    end
    puts @board
  end

end