require_relative 'row'
require_relative 'cell'
require 'pry'

class Board
  MIN_SIZE = 5
  MAX_SIZE = 25

  attr_accessor :board_size, :grid, :mine_locations, :remaining_flags
  def initialize(board_size = MIN_SIZE)
    @board_size = verify_board_size(board_size)
    @grid = []
    build
    @mine_locations = []
    @max_visible_cells = board_size * (board_size -1)
    @visible_cell_count = 0
    @remaining_flags = board_size
    locate_mines
    add_hint_values
  end

  def render
    display_all_cells
    display_mine_and_flag_counts
  end

  # private


  def display_all_cells
    header = '     '
    (0...board_size).each do |num|
      if num < 10
        header << "#{num}  "
      else
        header << "#{num} "
      end
    end

    p header
    p '   -' + '---' * board_size
    row_number = 0
    grid.each do |row|
      if row_number < 10
        row.unshift("#{row_number}  |")
      else
        row.unshift("#{row_number} |")
      end
      row_number += 1
    end

    grid.each do |row|
      p row.map(&:to_s).join(' ')
    end
  end

  def display_mine_and_flag_counts
    puts "Mines: #{@mine_locations.count} | Remaining Flags: #{@remaining_flags}", ""
  end

  def refresh_display_headers
    grid.map do |row|
      row.shift
    end
  end

  def build
    @grid = Array.new(board_size) { Row.new.build(board_size) }
  end

  def locate_mines
    grid.each do |row|
      row.each do |cell|
        mine_locations << [grid.index(row), row.index(cell)] if cell.is_a?(Mine)
      end
    end
  end

  def add_hint_values
    mine_locations.each do |location|

      [-1, 0, 1].each do |row_modifier|
        row_address = location[0] + row_modifier

        [-1,0,1].each do |column_modifier|
          column_address = location[1] + column_modifier
          next unless (0...board_size).include?(row_address) && (0...board_size).include?(column_address)
          grid[row_address][column_address].value += 1
        end #column
      end #row
    end #locations
  end

  def verify_board_size(board_size)
    raise ArgumentError if board_size < MIN_SIZE || board_size > MAX_SIZE
    board_size == 0 ? MIN_SIZE : board_size
  end

  def all_cleared?
    @visible_cell_count = Cell.count_visible
    @visible_cell_count == @max_visible_cells
  end


end #Board

# puts "Welcome to Minesweeper"
# puts "Watch your step!", ""
# board = Board.new(15)
# board.display_all_cells
# board.add_hint_values


