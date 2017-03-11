require_relative './cell.rb'

module Minesweeper
  class Board
    attr_reader :grid,
                :flags

    def initialize(grid = nil)
      @mines = 9
      @flags = 9
      @rows = 10
      @cols = 10
      @grid = grid.nil? ? Array.new(@rows) { Array.new(@cols) { Cell.new } } : grid  
    end

    # randomly sets 9 Cells in the grid to be mines
    # TODO: refactor to accept variable number of mines
    def setup_minefield
      mines_left = @mines

      until mines_left == 0
        row, col = rand(0..9), rand(0..9)
        cell = @grid[row][col]

        unless cell.mine
          cell.mine = true
          mines_left -= 1
        end
      end
    end

    # checks whether the provided row/col is valid
    def valid_coordinate?(row, col)
      unless row.is_a?(Fixnum) && col.is_a?(Fixnum)
        raise "Your inputs to this method must be integers."
      end

      valid_range = (0..9).to_a
      valid_range.include?(row) && valid_range.include?(col)
    end

    # given the coordinates of a Cell, returns its adjacent Cells
    def adjacent_cells(row, col)
      cells = []
      
      (-1..1).each do |row_offset|
        (-1..1).each do |col_offset|
          next if row_offset == 0 && col_offset == 0
          next if row + row_offset < 0 || row + row_offset > 9
          next if col + col_offset < 0 || col + col_offset > 9
          
          cells << grid[row + row_offset][col + col_offset]
        end
      end

      cells
    end

    # given the coordinates of a Cell, calculates how many mines it has
    # in its adjacent Cells
    def adjacent_mines(row, col)
      adjacent_cells(row, col).count { |cell| cell.mine }
    end

    # determines if there are still flags remaining
    def flags_left?
      flags > 0
    end

    # reduces the number of flags by 1
    def decrement_flags
      @flags -= 1
    end

    # increases the number of flags by 1
    def increment_flags
      @flags += 1
    end
  end
end