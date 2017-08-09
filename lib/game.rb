require './lib/board.rb'

class Game
  attr_accessor :board

  def initialize(x, y, mines)
    if mines > (x * y)
      raise 'The mines exceed the number of mines exceeds the board size.'
    else
      @board = Board.new(x, y, mines)
    end
  end

  def click(x, y)
    clicked = @board.click(x, y)

    if clicked == 'mine'
      game_over
    elsif clicked == 'revealed'
      revealed
    else
      raise 'Some weird shit happened.'
    end

    @board.print_board

  end

  private

  def game_over
    p 'Game over :('
  end

  def revealed
    p 'Phew! No bomb.'
  end

end

start = Game.new(4, 4, 5)
start.click(2, 2)
