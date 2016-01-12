require_relative 'board.rb'
require_relative 'player.rb'

class Minesweeper

  attr_accessor :board, :player

  def initialize
    @board = Board.new
    @player = Player.new
    @game_over = false
  end

  def game
    @board.mine_coords(10)
    place_mines(@board.mines)
    instructions

    loop do
      @board.render
      coords = @player.choose_coords
      kind = @player.move_kind
      @game_over = make_move(coords, kind)
      if @game_over
      	puts "You lose!"
      	@board.render
      	break
      end
    end
  end

	private

  def instructions
  	puts "Welcome to Minesweeper!"
  	puts "To play, select coordinates (i.e: [1,2])"
  	puts "Then choose if you want to place a flag or reveal the square"
  	puts "If you hit a mine, you lose!"
  end

  def make_move(coords, kind)
    if kind == "reveal"
      @board.reveal_tile(coords)
      return @board.board[coords[0]][coords[1]].is_mine
    elsif kind == "flag"
      @board.toggle_flag(coords)
      return false
    else
      puts "Invalid choice"
      @player.move_kind
      # invalid choice leads to move not saving
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