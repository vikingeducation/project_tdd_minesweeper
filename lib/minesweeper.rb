require_relative 'board.rb'

class Minesweeper

  def initialize
    @board = Board.new
  end

  def play
    @board.place_mines
    @board.render
  end

end