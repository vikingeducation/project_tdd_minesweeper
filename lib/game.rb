include 'minesweeper_cli.rb'

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
  end

  def get_input
    [1,2]
  end
end
