require 'board'
require 'minesweeper_cli'

class Game
  def initialize(user_interface=MinesweeperCLI.new)
    @board = Board.new
    @user_interface = user_interface
  end

  def play
    render
    game_loop
  end

  def game_loop
    make_move(get_input)
    game_over?
    render
  end

  private

  def get_input
    @coord = @user_interface.get_coordinates
  end

  def make_move(coord)
    @board.move(coord)
  end

  def game_over?
  end

  def render
    @user_interface.render(@board.grid)
  end
end
