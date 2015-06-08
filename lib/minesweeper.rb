require_relative 'board'
require_relative 'player'
require 'pry'

class Minesweeper

  def initialize(height = 10, width = 10, number_of_mines = 9)
    @board = Board.new(height, width, number_of_mines)
    @player = Player.new(width, height)
  end

  def start
    system("clear")
    @board.place_mines
    @board.run_nearby_mines
    @board.render
    gameplay
  end

  def gameplay
    loop do
      move = @player.take_turn
      system("clear")
      @board.process(move)
      @board.render

      break if @board.defeat || @board.victory

    end

    endgame

  end


  def endgame
    if @board.defeat
      loser
    else
      winner
    end
  end


  def loser
    puts "BOOM!  You have struck a mine."
    print "\n"
    puts "Thanks for playing!"
  end


  def winner
    puts "You win!  Thanks for playing!"
  end

end