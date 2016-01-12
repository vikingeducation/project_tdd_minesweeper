require_relative 'board'
require_relative 'minesweeper_cli'

class Game
  def initialize(user_interface=MinesweeperCLI.new)
    @board = Board.new
    @user_interface = user_interface
    @first_move = true
  end

  def play
    render
    game_loop
  end

  def game_loop
    until game_over?
      make_move(get_input)
      @board.check_neighbors
      render
    end
  end

  def game_over?
    false
  end

  private

  def get_input
    @coord = @user_interface.get_coordinates
  end

  def make_move(coord)
    if @first_move
      @board.populate_board(coord)
      @first_move = false
    end
    @board.move(coord)
  end

  def game_over?
  end

  def render
    @user_interface.render(@board)
  end
end
