module Minesweeper
  class Game
    attr_reader :player,
                :board,
                :renderer

    def initialize
      @player = Player.new
      @board = Board.new
      @renderer = Renderer.new
    end
  end
end