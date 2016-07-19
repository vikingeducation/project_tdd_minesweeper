require_relative "player"
require_relative "board"
require_relative "view"

class Minesweeper
  def initialize(board = Board.new, view = View.new, player = Player.new)
    @board = board
    @view = view
    @player = player
  end



end
