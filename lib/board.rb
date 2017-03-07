module Minesweeper
  class Board
    attr_reader :grid,
                :flags

    def initialize(grid = nil)
      @grid = grid.nil? ? Array.new(10) { Array.new(10, nil) } : grid
      @flags = 9
    end

    # TODO: make this method private and implicitly test it
    def setup_minefield
    end
  end
end