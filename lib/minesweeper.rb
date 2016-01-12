require_relative 'board.rb'
require_relative 'player.rb'

class Minesweeper
	#mine_coords(MINES)
  #place_mines(coords)
  attr_accessor :board, :player

  def initialize
    @board = Board.new
    @player = Player.new
  end

  def game
    @board.mine_coords(10)
    place_mines(@board.mines)

    loop do
      @board.render
      coords = @player.choose_coords
      kind = @player.move_kind
      make_move(coords, kind)
    end
  end

  def make_move(coords, kind)
    if kind == "reveal"
      @board.reveal_tile(coords)
    elsif kind == "flag"
      @board.toggle_flag(coords)
    else
      puts "Invalid choice"
      @player.move_kind
    end
  end

  def place_mines(mine_coords)
    mine_coords.each do |mine|
      @board.board[mine[0]][mine[1]].make_mine
    end
  end
end

g = Minesweeper.new
g.game