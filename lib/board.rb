class Board
  attr_reader :board

  def initialize
    @board = Array.new(10) { Array.new(10) }
  end

  def make_mine_coords
    mines=[]
    until mines.size==9
      x=(1..10).sample
      y=(1..10).sample
      mines << [x,y] unless mines.include?[x,y]
    end
    mines
  end

  def place_mines
    make_mine_coords.each do |coords|
      place_cell(coords[0],coords[1],Mine.new(coords,self))
    end
  end

  def fill_board
    (1..10).each do |x|
      (1..10).each do |y|
        place_cell(x,y,Cell.new([x,y],self)) unless at_coord(x,y)
      end
    end
  end

  def place_cell(x,y,cell)
    @board[x-1][y-1]=cell
  end

  def at_coord(x, y)
    @board[x-1][y-1]
  end

  # [ [5, 6], [5, 7] ]
  def get_cell_at_xy(input_array)
    input_array.map do |coord|
      x = coord[0]
      y = coord[1]
      at_coord(x, y)
    end
  end
end
