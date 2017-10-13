require_relative 'row'
require_relative 'cell'
require 'pry'

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
    add_hint_values
  end

  def render
    grid
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


end #Board

# puts "Welcome to Minesweeper"
# puts "Watch your step!", ""
# board = Board.new(15)
# board.display_all_cells
# board.add_hint_values


