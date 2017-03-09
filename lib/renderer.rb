module Minesweeper
  class Renderer
    attr_reader :board

    def initialize(board = nil)
      @board = board.nil? ? nil : board
    end
  end
end