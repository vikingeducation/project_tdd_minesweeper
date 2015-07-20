require_relative 'cell'
require 'pry'

class Board
  attr_accessor :grid
  attr_reader :range
  
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

  def flag_cell(coords)
    unless cell(coords).flagged?
      cell(coords).flag!
      true
    else
      puts "Cell already flagged!"
      false
    end
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
    count = neighbors.count { |coords| cell(coords).mined? }
    cell(coords).mined_neighbors = count 
  end

  def get_neighbors(coords)
    row = coords[0]
    col = coords[1]
    neighbors = []

    possible_coords = [
    [row-1, col-1], [row-1, col], [row-1, col+1],
    [row, col-1],                 [row, col+1],
    [row+1, col-1], [row+1, col], [row+1, col+1]]

    possible_coords.each do |coords|
      if @range.include?(coords[0]) &&
         @range.include?(coords[1])
        neighbors << [coords[0],coords[1]]
      end
    end

    neighbors
  end

  def clear_grid_around_cell(coords)
    queue = [coords]
    until queue.empty?

      test_cell = queue.pop
      neighbors = get_neighbors( test_cell )

      neighbors.delete_if { |coords| ignore_cell_when_clearing?( coords ) }
      neighbors.each { |coords| cell(coords).reveal! }
      neighbors.delete_if { |coords| cell(coords).mined_neighbors > 0 }

      queue = queue + neighbors
    end
  end

  def reveal_cells(coords)
    coords.each do |coord|
      cell(coord).reveal! if auto_reveal_cell?(coord)
    end
  end

  def auto_reveal_cell?(coords) 
    cell(coords).covered? == true &&
    cell(coords).mined? == false &&
    cell(coords).flagged? == false
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