require_relative 'board'
require_relative 'player'

class Minesweepers
  attr_reader :board, :player

  def initialize (board_size = 10, bombs = 9, board = nil)
    @board = board || Board.new(board_size, bombs)
    @player = Player.new
  end

  def play
    @board.create_bombs
    @board.create_bomb_indication
    instruction

    until @board.game_over
      @board.render_board
      input = @player.get_input

      @board.check_move input
      @board.check_game_over
    end
    @board.render_board true
  end

  def instruction
    puts "********************************

    Hello, Welcome to Minesweepers
    You need to choose a Column and a Row,
    and (c) Clear or (f) Flag the position !
    As the example ( 1,2,c )
    ********************************
    "
  end
end

game = Minesweepers.new
game.play