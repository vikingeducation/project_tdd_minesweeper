require_relative 'board'
require_relative 'player'
require 'rainbow'

class Game
  attr_reader :board, :player

  def initialize(size = 10, mines = 9, player_name = nil, board=nil)
    @board = board || Board.new(size, mines)
    @player = Player.new(@board, player_name)
  end

  def play
    @board.render

    loop do
      break if game_over?
      @player.take_turn
      @board.render
    end
  end

  private

  def game_over?
    win? || loss?
  end

  def win?
    false
  end

  def loss?
    if @board.last_move_bomb
      puts Rainbow("\nI'm sorry, #{@player.name}.  You lost. :(").red
      true
    else
      false
    end
  end

end