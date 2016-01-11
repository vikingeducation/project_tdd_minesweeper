require 'board'
require 'minesweeper_cli'

class Game
  def initialize(user_interface=MinesweeperCLI.new)
    @user_interface = user_interface
    @board = Board.new
  end

  def play
    setup
    game_loop
  end

  def setup

  end

  def game_loop
    make_move(get_input)
    game_over?
    render
  end

  def get_input
    @coord = @user_interface.get_coordinates
  end

  def make_move(coord)
    @board.move(coord)
  end

  def game_over?
  end

  def render
    @user_interface.render(@board)
  end
end
