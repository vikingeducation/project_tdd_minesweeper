require_relative 'minesweeper'

class Game
  attr_reader :board

  def initialize(row = 10, col = 10)
    @board = Minesweeper.new(row, col)
  end

  def play
    @board.print_instructions
    @board.turn until @board.game_over?
    @board.uncover_board
    @board.render
  end
end
