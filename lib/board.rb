require_relative './cell.rb'

module Minesweeper
  class Board
    attr_reader :grid,
                :flags

    def initialize(grid = nil)
      @grid = grid.nil? ? Array.new(10) { Array.new(10, Cell.new) } : grid
      @flags = 9
    end
  end
end