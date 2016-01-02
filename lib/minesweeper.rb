require_relative 'board'
require_relative 'player'

class Minesweeper
  def initialize
    @board = Board.new
    @player = Player.new(@board)
  end

  def start_game
    puts "Minesweeper"
    puts "By Steven Chang"
    puts "---------------"
    puts ""
    puts "Minesweeper is a single-player puzzle video game. The objective of the game is to clear a rectangular board containing hidden mines without detonating any of them, with help from clues about the number of neighboring mines in each field."
    puts ""
    puts "Lets Go!"
    puts ""
    @board.place_random_mines
    @board.set_up_rest_of_answer_grid
    loop do
      @board.render
      @player.turn
      if @board.lose?
        @board.render
        puts "You Lose!"
        exit
      elsif @board.win?
        @board.render
        puts "You Win!"
        exit
      end
    end
  end
end

Minesweeper.new.start_game