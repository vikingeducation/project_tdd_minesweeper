require 'minesweeper'

class Game
  attr_reader :board

  def initialize(row = 10, col = 10)
    @board = Minesweeper.new(row, col)
  end

  def play
    @board.render
    @board.turn until @board.game_over?
  end
end
