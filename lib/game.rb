require_relative 'board'

class Game
  attr_accessor :board
  def initialize
    @board = Board.new
  end
  def make_move
    move = gets.chomp.split(',')
    raise 'invalid input' if move.size < 3
    move
  end
end

#@game = Game.new
#@game.board.assign_mine_coordinates
#@game.board.update_board(@game.make_move)
#@game.board.render_board

