require_relative 'board'
require_relative 'player'

class Game
  attr_reader :board, :player

  def initialize(size = 10, mines = 9, player_name = nil)
    @board = Board.new(size, mines)
    @player = Player.new(@board, player_name)
  end

  def play
    @player.take_turn
  end

end