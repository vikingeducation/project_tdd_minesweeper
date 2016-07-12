class Minesweeper
  def initialize
    @square = Square.new
    @board = Board.new(@square)
    @view = View.new(@board)
    @player = Player.new(@view)
  end
end