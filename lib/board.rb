require_relative 'cell'
require 'pry'

class Board
  attr_reader :range, :grid
  
  def initialize(grid = nil)
    @grid = grid || blank_grid
    @range = ( 0..(@grid.keys.max) )
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
      random_row = @range.to_a.sample
      random_col = @range.to_a.sample
      cell = @grid[random_row][random_col]
      cell.mined? ? next : cell.mine!
    end
  end

  def cell(coords)
    return nil unless coords.all? { |i| @range.include?(i) }
    @grid[coords[0]][coords[1]]
  end


  def set_mined_neighbors_for_all_cells
    @grid.each_key do |row|
      @grid[row].each_index do |col|
        count_mined_neighbors( [row, col] )
      end
    end
  end

  def count_mined_neighbors(coords)
    neighbors = get_neighbors(coords)
    count = neighbors.count { |neighbor| cell(neighbor).mined? }
    cell(coords).mined_neighbors = count 
  end

  def get_neighbors(coords)
    row = coords[0]
    col = coords[1]
    neighbors = []

    possible_neighbors = [
    [row-1, col-1], [row-1, col], [row-1, col+1],
    [row, col-1],                 [row, col+1],
    [row+1, col-1], [row+1, col], [row+1, col+1]]

    possible_neighbors.each do |neighbor|
      unless cell(neighbor) == nil
        neighbors << neighbor
      end
    end

    neighbors
  end

  def flag_cell(coords)
    cell(coords).flag!
  end

  def mined?(coords)
    cell(coords).mined?    
  end

  def victory?
    flagged = @grid.values.flatten.select { |cell| cell.flagged? }
    mined = @grid.values.flatten.select { |cell| cell.mined? }
    flagged == mined
  end

  def auto_reveal_search(coords)
    queue = [coords]
    until queue.empty?

      test_cell = queue.pop
      neighbors = get_neighbors( test_cell )

      queue += queue_cells_for_search(neighbors)

      auto_reveal_cells(neighbors)

    end
  end

  def auto_reveal_cells(cells)
    cells.each do |coords|
      cell(coords).reveal! if auto_reveal?(coords)
    end
  end

  def queue_cells_for_search(cells)
    queue = []
    cells.each do |coords|
      queue << coords if add_to_queue?(coords)
    end
    queue
  end

  def auto_reveal?(coords) 
    cell(coords).covered? == true &&
    cell(coords).mined? == false &&
    cell(coords).flagged? == false
  end


  def add_to_queue?(coords)
    auto_reveal?(coords) && cell(coords).mined_neighbors == 0
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
    if cell.covered? == false && cell.mined_neighbors > 0
      print "[#{cell.mined_neighbors}]"
    elsif cell.covered? == false
      print "[c]"
    elsif cell.flagged?
      print "[f]"
    elsif cell.mined?
      print "[*]"
    else
      print "[ ]"
    end
  end

end