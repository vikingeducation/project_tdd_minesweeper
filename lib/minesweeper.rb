require_relative 'board'
require_relative 'player'
require 'pry'

class Minesweeper

  def initialize(height = 10, width = 10, number_of_mines = 9)
    @board = Board.new(height, width, number_of_mines)
  end

  def start
    @board.place_mines
    @board.render
    #first user input
  end
end