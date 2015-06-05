require_relative 'board'
require_relative 'player'
require 'pry'

class Minesweeper

  def initialize(height, width)
    @board = Board.new(height, width)
  end

  def start
    @board.render
  end
end