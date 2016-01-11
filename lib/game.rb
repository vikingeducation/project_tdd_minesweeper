require 'minesweeper_cli'

class Game
  def initialize(user_interface=MSCLI.new)
    @user_interface = user_interface
  end

  def play
    setup
    game_loop
  end

  def setup

  end

  def game_loop
    get_input
    make_move(@coord)
    game_over?
  end

  def get_input
    @coord = @user_interface.get_coordinates
  end

  def make_move(coord)
    

  end

  def game_over?

  end
end
