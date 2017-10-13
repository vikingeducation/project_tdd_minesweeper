require_relative 'row'
require_relative 'cell'

class Board
  MIN_SIZE = 8
  MAX_SIZE = 25

  attr_accessor :board_size, :grid, :mine_locations
  def initialize(board_size = MIN_SIZE)
    @board_size = verify_board_size(board_size)
    @grid = []
    build
    @mine_locations = []
    locate_mines
  end

  def render
    grid
    # add_cell_values
  end

  # private

  def build
    board_size.times do
      grid << Row.new.build(board_size)
    end
  end

  def locate_mines
    grid.each do |row|
      row.each do |cell|
        mine_locations << [grid.index(row), row.index(cell)] if cell.is_a?(Mine)
      end
    end
  end

  def add_cell_values
    mine_locations.each do |location|
      set_top_left(location)
    end
  end

  def set_top_left(loc)
    grid[loc[0]-1][loc[1]-1].value += 1
  end

  def verify_board_size(board_size)
    raise ArgumentError if board_size < MIN_SIZE || board_size > MAX_SIZE
    board_size == 0 ? MIN_SIZE : board_size
  end


end #Board

# puts "Welcome to Minesweeper"
# puts "Watch your step!", ""
# board = Board.new(10)
# p board.render
# board.add_cell_values

# board_size = 10
# grid = []
# board_size.times do
#   grid << Array.new(Array.new(board_size, 0))
# end

# grid.each do |row|
#   p row.object_id
#   mine = (0..(board_size - 1)).to_a.sample
#   row[mine] = 'b'
# end

# p grid

# grid2 = [
#   [[0],[0],[0],[0],[0],0,0,0,0,0],
#   ['0','0','0','0','0','0',0,0,0,0],
#   [0,0,0,0,0,0,0,0,0,0],
#   [0,0,0,0,0,0,0,0,0,0],
#   [0,0,0,0,0,0,0,0,0,0],
#   [0,0,0,0,0,0,0,0,0,0],
#   [0,0,0,0,0,0,0,0,0,0],
#   [0,0,0,0,0,0,0,0,0,0],
#   [0,0,0,0,0,0,0,0,0,0],
#   [0,0,0,0,0,0,0,0,0,0]
# ]

# grid2.each do |row|
#   p "row: #{row.object_id}"
#   row.each_with_index do |col, i|
#     p "col #{i}: #{col.object_id}"
#   end
# end


