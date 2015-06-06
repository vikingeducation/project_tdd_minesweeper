require_relative 'board'
require_relative 'player'
require 'pry'

class Minesweeper

  def initialize(height = 10, width = 10, number_of_mines = 9)
    @board = Board.new(height, width, number_of_mines)
    @player = Player.new(width, height)
  end

  def start
    @board.place_mines
    @board.run_nearby_mines
    @board.render
    gameplay
  end

  def gameplay
    loop do
      move = @player.take_turn
      @board.process(move)
      @board.render
      #board provides feedback
      break if @board.defeat
      #break if endgame
    end

    loser

    #win/loss fork
  end

  def loser
    puts "BOOM!  You have struck a mine."
    print "\n"
    puts "Thanks for playing!"
  end

end