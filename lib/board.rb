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

  def neighbors(coords)
    
  end

  # private
  def place_mines(mine_coords)
    mine_coords.each do |mine|
      @board[mine[0]][mine[1]].make_mine
    end
    print mine_coords
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