module Minesweeper
  class Renderer
    attr_accessor :board

    def initialize(board = nil)
      @board = board.nil? ? nil : board
    end
  end
end