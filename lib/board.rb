require_relative 'cell'
require_relative 'logic'
require 'colorize'

class Board
  include Logic
  attr_reader :range, :grid
  attr_writer :status_message

  
  def initialize(grid = nil)
    @grid = grid || blank_grid
    @range = ( 0..(@grid.keys.max) )
    @status_message = nil
    @flags = 9
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


  def set_mined_neighbors_for_all_cells
    @grid.each_key do |row|
      @grid[row].each_index do |col|
        count_mined_neighbors( [row, col] )
      end
    end
  end


  def make_move(coords, action)
    if cell(coords)
      if action == :flag
        flag_cell(coords)
        return true
      elsif action == :reveal
        cell(coords).flag! if cell(coords).flagged? 
        cell(coords).reveal!
        auto_reveal_search(coords)
        return true
      end
    end
  end

  def revealed_mine?
    @grid.values.flatten.any? do |cell|
      cell.covered? == false && 
      cell.mined? 
    end
  end


  def flag_cell(coords)
    if cell(coords).flagged?
      @flags += 1
    else
      @flags -= 1
    end
    cell(coords).flag!
  end


  def victory?
    flagged = @grid.values.flatten.select { |cell| cell.flagged? }
    mined = @grid.values.flatten.select { |cell| cell.mined? }
    flagged == mined
  end


  def render_grid(game_over = false)
    system "clear"
    puts "Welcome to Minesweeper, first enter the" 
    puts "coordinates of a cell.  Then if you'd like"
    puts "to flag or reveal that cell.\n\n"

    print "   "
    (0..9).each { |num| print " #{num} "}
    print "\n"

    @grid.each do |row_num, row|
      print " #{row_num} "
      row.each do |cell|
        render_cell(cell, game_over)
      end
      print "\n"
    end
    puts "\nFlags remaining: #{@flags}"
    puts "#{@status_message}\n\n"
    nil
  end


  def render_cell(cell, game_over)
    if game_over && cell.flagged? && cell.mined?
      print "[F]".colorize(:light_red)
    elsif cell.flagged?
      print "[f]".colorize(:red)
    elsif game_over && cell.mined? #|| cell.mined?
      print "[*]".colorize(:light_yellow)
    elsif game_over && cell.mined_neighbors > 0 || 
          cell.covered? == false && cell.mined_neighbors > 0
      print "[#{cell.mined_neighbors}]".colorize(:light_black)
    elsif game_over || cell.covered? == false
      print "   "
    else
      print "[ ]".colorize(:light_black)
    end
  end

end