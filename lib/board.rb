require_relative './cell.rb'

module Minesweeper
  class Board
    attr_reader :grid,
                :flags

    def initialize(grid = nil)
      @grid = grid.nil? ? Array.new(10) { Array.new(10) { Cell.new } } : grid
      @flags = 9
    end

    # randomly sets 9 Cells in the grid to be mines
    # TODO: refactor to accept variable number of mines
    def setup_minefield
      mines_left = 9

      until mines_left == 0
        row, col = rand(0..9), rand(0..9)
        cell = @grid[row][col]

        unless cell.mine
          cell.mine = true
          mines_left -= 1
        end
      end
    end
  end
end