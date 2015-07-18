require_relative 'cell'

class Board
  attr_accessor :grid
  
  def initialize(grid = nil)
    @grid = grid || blank_grid
  end

  def blank_grid
    @grid = {}
    10.times do |row_num|
      row = []
      10.times { row << Cell.new }
      @grid[row_num] = row
    end
    @grid
  end

  def place_mines
    9.times do
      random_row = self.grid.keys.sample
      random_col = rand(0..9)
      cell = @grid[random_row][random_col]
      cell.mined? ? next : cell.mine!
    end
  end

  def flag_cell(row, col)
    if @grid[row][col].flagged?
      puts "Cell already flagged!"
      false
    else
      @grid[row][col].flag!
      true
    end
  end

  def count_mined_neighbors(row, col)
    neighbors = get_neighbors(row, col)
    neighbors.count { |coord| @grid[coord[0]][coord[1]].mined? } 
  end

  def get_neighbors(row, col)
    neighbors = []

    possible_coords = [
    [row-1, col-1], [row-1, col], [row-1, col+1],
    [row, col-1],                 [row, col+1],
    [row+1, col-1], [row+1, col], [row+1, col-1]]

    possible_coords.each do |coord|
      unless @grid[coord[0]] == nil || 
             @grid[coord[0]][coord[1]] == nil
             neighbors << [coord[0],coord[1]]
      end
    end

    neighbors
  end

  def clear_grid_around_cell(row, col)
    cells_to_check = [[row,col]]

    until cells_to_check.empty?

      cells_to_check.each do |coords|

        to_clear = get_neighbors(coords[0], coords[1])

        to_clear.delete_if do |coord|
          count_mined_neighbors(coord[0], coord[1]) > 0 || 
          @grid[coord[0]][coord[1]].covered? == false ||
          @grid[coord[0]][coord[1]].mined? == true ||
          @grid[coord[0]][coord[1]].flagged? == true
        end

        to_clear.each do |coord|
          @grid[coord[0]][coord[1]].reveal!
        end

        cells_to_check.clear
        cells_to_check = to_clear

      end

    end

  end

  def render_grid
    @grid.each_value do |row|
      row.each do |cell|
        render_cell(cell)
      end
      print "\n"
    end
    nil
  end

  def render_cell(cell)
    if cell.covered? == false
      print "[c]"
    elsif cell.flagged?
      print "[f]"
    elsif cell.mined_neighbors > 0
      print "#{cell.mined_neighbors}"
    else
      print "[ ]"
    end
  end

end