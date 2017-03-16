require_relative './cell.rb'

module Minesweeper
  class Board
    attr_reader :grid,
                :flags,
                :rows,
                :cols,
                :mines

    def initialize(grid = nil, mines = nil)
      @mines = 9
      @flags = 9
      @rows = 10
      @cols = 10

      unless mines.nil?
        @mines = mines
        @flags = mines
      end

      unless grid.nil?
        @grid = grid
        @rows = grid.size
        @cols = grid[0].size
      else
        @grid = Array.new(@rows) { Array.new(@cols) { Cell.new } }
      end
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
    # TODO: make this method private
    def valid_coordinate?(row, col)
      unless row.is_a?(Fixnum) && col.is_a?(Fixnum)
        raise "Your inputs to this method must be integers."
      end

      valid_row_range = (0...@rows)
      valid_col_range = (0...@cols)
      valid_row_range.include?(row) && valid_col_range.include?(col)
    end

    # checks whether the Cell at the provided row/col is cleared
    def cell_cleared?(row, col)
      grid[row][col].state == :cleared
    end

    # checks whehter the Cell at the provided row/col is flagged
    def cell_flagged?(row, col)
      grid[row][col].state == :flagged
    end

    # checks whether the Cell at the provided row/col has a mine
    def cell_has_mine?(row, col)
      grid[row][col].mine
    end

    # convenience methods
    def clear(row, col)
      grid[row][col].clear
      grid[row][col].adjacent_mine_count = adjacent_mines(row, col)
    end

    def flag(row, col)
      grid[row][col].flag
      self.flags -= 1
    end

    def unflag(row, col)
      grid[row][col].unflag
      self.flags += 1
    end

    # given the coordinates of a Cell, returns its adjacent Cells
    # TODO: make this method private
    def adjacent_cells(row, col)
      cells = []
      
      (-1..1).each do |row_offset|
        (-1..1).each do |col_offset|
          # do not check the same Cell
          next if row_offset == 0 && col_offset == 0
          
          next if row + row_offset < 0 || row + row_offset >= @rows
          next if col + col_offset < 0 || col + col_offset >= @cols
          
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

    # checks whether all safe cells (those without a mine) 
    # have been cleared (victory condition)
    def all_safe_cells_cleared?
      (0...rows).each do |row|
        (0...cols).each do |col|
          if cell_cleared?(row, col) && !cell_has_mine?(row, col)
            next
          else
            return false
          end
        end
      end

      true
    end

    private

    attr_writer :flags
  end
end