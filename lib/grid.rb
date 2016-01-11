require_relative 'square'

class Grid

  attr_accessor :grid, :mines_hash

  def initialize(grid=nil)
    @height = 9
    @width = 9
    @num_mines = 10
    @mines_hash = {}
    @grid = Array.new(@width){Array.new(@height){Square.new}}
  end

  def import_grid( new_grid )
    # assumes new_grid is a 2x2 array of characters
    # "*" == bomb, " " == no_bomb
    return unless new_grid.length == @width && new_grid[0].length == @height
    (0..@width - 1).each do | row_index |
      (0..@height - 1).each do | col_index |
        @grid[row_index][col_index] = Square.new
        if new_grid[row_index][col_index] == "*"
          @grid[row_index][col_index].has_bomb = true
        else
          @grid[row_index][col_index].has_bomb = false
        end
      end
    end
  end

  def build_mines_hash 
    until mines_hash.length == @num_mines do
      loop do 
        x,y = rand(0..@height-1), rand(0..@width-1)
        unless @mines_hash[[x,y]]
          @mines_hash[[x,y]] = true
          break
        end
      end
    end
  end

  def place_bombs
    @grid.each_with_index do |row, i|
      row.each_with_index do |column, j|
        @mines_hash.include?([i,j]) ? @grid[i][j].has_bomb = true : @grid[i][j].has_bomb = false
      end
    end
  end

  def place_flag(i,j)
    @grid[i][j].flagged = true
  end


  def calculate_adjacent_bombs( i, j )  
    horizontal_arr = [ i-1, i, i + 1] if i > 0 && i < @width - 1
    horizontal_arr = [ i, i + 1] if i == 0
    horizontal_arr = [ i-1, i ] if i == @width - 1

    vertical_arr = [ j-1, j, j + 1] if j > 0 && j < @height - 1
    vertical_arr = [ j, j + 1] if j == 0
    vertical_arr = [ j-1, j ] if j == @height - 1

    num_adjacent_bombs = 0
    horizontal_arr.each do | row_index |
      vertical_arr.each do | col_index |
        num_adjacent_bombs += 1  if @grid[row_index][col_index].has_bomb
      end
    end
    @grid[i][j].has_bomb ? num_adjacent_bombs - 1 : num_adjacent_bombs
  end


  def calculate_adjacent_flags(i,j)
    horizontal_arr = [ i-1, i, i + 1] if i > 0 && i < @width - 1
    horizontal_arr = [ i, i + 1] if i == 0
    horizontal_arr = [ i-1, i ] if i == @width - 1

    vertical_arr = [ j-1, j, j + 1] if j > 0 && j < @height - 1
    vertical_arr = [ j, j + 1] if j == 0
    vertical_arr = [ j-1, j ] if j == @height - 1

    num_adjacent_flags = 0
    horizontal_arr.each do | row_index |
      vertical_arr.each do | col_index |
        num_adjacent_flags += 1  if @grid[row_index][col_index].flagged
      end
    end
    @grid[i][j].flagged ? num_adjacent_flags - 1 : num_adjacent_flags
  end

end

