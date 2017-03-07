module Minesweeper
  class Board
    attr_reader :grid,
                :flags

    def initialize
      @grid = Array.new(10) { Array.new(10, nil) }
      @flags = 9
    end
  end
end