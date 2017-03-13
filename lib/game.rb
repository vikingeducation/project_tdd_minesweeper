module Minesweeper
  attr_reader :player,
              :board,
              :renderer

  class Game
    def initialize
      @player = Player.new
      @board = Board.new
      @renderer = Renderer.new
    end
  end
end