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

    # randomly sets cells in the grid to have mines
    def setup_minefield
      mines_left = @mines

      until mines_left == 0
        row, col = rand(0...rows), rand(0...cols)
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

      valid_row_range = (0...@rows)
      valid_col_range = (0...@cols)
      valid_row_range.include?(row) && valid_col_range.include?(col)
    end

    # checks whether the cell at the provided row/col is cleared
    def cell_cleared?(row, col)
      grid[row][col].state == :cleared
    end

    # checks whehter the cell at the provided row/col is flagged
    def cell_flagged?(row, col)
      grid[row][col].state == :flagged
    end

    # checks whether the cell at the provided row/col has a mine
    def cell_has_mine?(row, col)
      grid[row][col].mine
    end

    # clears a cell, unless the cell is already flagged
    # if the cleared cell has 0 adjacent mines, recursively clear
    # all its adjacent mines as well
    def clear(row, col)
      unless cell_flagged?(row, col)
        grid[row][col].clear
        adjacent_mine_count = adjacent_mines(row, col)
        grid[row][col].adjacent_mine_count = adjacent_mine_count

        if adjacent_mine_count == 0
          coords_to_autoclear = adjacent_cell_coords(row, col)
          coords_to_autoclear.each { |coord| clear(coord[0], coord[1]) unless cell_cleared?(coord[0], coord[1]) }
        end
      else
        puts "You must unflag a flagged cell before clearing it."
      end
    end

    # flags a cell, unless the cell is already cleared / flagged
    def flag(row, col)
      if cell_flagged?(row, col)
        puts "That cell is already flagged."
      elsif cell_cleared?(row, col)
        puts "You cannot flag a cleared cell."
      elsif !flags_left?
        puts "You have no more flags to place. Unflag a cell first."
      else
        grid[row][col].flag
        self.flags -= 1
      end
    end

    # unflags a cell, unless the cell is already cleared / unflagged
    def unflag(row, col)
      if cell_cleared?(row, col)
        puts "You cannot unflag a cleared cell."
      elsif !cell_flagged?(row, col)
        puts "That cell is already unflagged."
      else
        grid[row][col].unflag
        self.flags += 1
      end
    end

    # given the coordinates of a cell, returns the coordinates of its
    # adjacent cells
    def adjacent_cell_coords(row, col)
      coords = []
      
      (-1..1).each do |row_offset|
        (-1..1).each do |col_offset|
          # do not check the same cell
          next if row_offset == 0 && col_offset == 0
          
          next if row + row_offset < 0 || row + row_offset >= @rows
          next if col + col_offset < 0 || col + col_offset >= @cols
          
          coords << [row + row_offset, col + col_offset]
        end
      end

      coords
    end

    # given the coordinates of a cell, calculates how many mines it has
    # in its adjacent cells
    def adjacent_mines(row, col)
      adjacent_cell_coords(row, col).count { |coord| cell_has_mine?(coord[0], coord[1])}
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