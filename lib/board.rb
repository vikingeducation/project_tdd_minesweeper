class Board
  #maximum of 8 possible neighbors
  #[row, col]
  #[0,0] - [0, 1], [1, 1], [1, 0]
  #[5,5] - [4, 4], [5, 4], [6, 4]
  #        [4, 5], [6, 5] 
  #        [4, 6], [5, 6], [6, 6]

  ROWS = 10
  COLUMNS = 10
  MINES = 10
  attr_accessor :board, :mines

  def initialize
    @board = []
    @mines = []
    ROWS.times do
      @board.push(Array.new(COLUMNS) { Tile.new })
    end
    mine_coords(MINES)
    place_mines(@mines)
  end

  def check_for_mines(coords)
    
  end

  def neighbors(coords)
    neighbors = []
    [-1, 0, 1].each do |row_mod|
      [-1, 0, 1].each do |col_mod|
        new_row = coords[0] + row_mod
        new_col = coords[1] + col_mod

        if (0 <= new_row) && (new_row < ROWS) && (0 <= new_col) && (new_col < COLUMNS)
          neighbors << [new_row, new_col]
        end
      end
    end
    neighbors.delete(coords)
    neighbors
  end

  # private
  def place_mines(mine_coords)
    mine_coords.each do |mine|
      @board[mine[0]][mine[1]].make_mine
    end
  end

  def mine_coords(mines)
    return true if mines <= 0
    row = (0..ROWS-1).to_a.sample
    column = (0..COLUMNS-1).to_a.sample
    if @mines.include?([row, column])
      mine_coords(mines)
    else
      @mines << [row, column]
      mine_coords(mines-1)
    end
  end
end