require './lib/board.rb'

class Game
  attr_accessor :board

  def initialize(x, y, mines)
    if mines > (x * y)
      fail 'The mines exceed the number of mines exceeds the board size.'
    else
      @board = Board.new(x, y, mines)
    end
  end

  def click(x, y)
    clicked = @board.click(x, y)

    if clicked == 'bomb'
      game_over
    elsif clicked == 'revealed'
      revealed
    else
      fail 'Some weird shit happened.'
    end

    @board.print_board

  end

  def flag(x, y)
    @board.flag(x, y)
  end

  private

  def game_over
    p 'Game over :('
  end

  def revealed
    p 'Already revealed. Try another.'
  end

end

start = Game.new(4, 4, 6)
start.click(2, 2)
