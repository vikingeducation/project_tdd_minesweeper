require_relative 'board.rb'
require_relative 'player.rb'

class Minesweeper

  def initialize
    @board = Board.new
    @player = Player.new(@board)
  end

  def play
    welcome
    @board.place_mines
    loop do
      @board.render
      @player.get_move
    end
  end

  def welcome
    puts "#########################"
    puts "#       Welcome to      #"
    puts "#       Minesweeper     #"
    puts "#########################"
    puts
    puts "You have 9 mines to find"
    puts "...and clear, good luck!"
  end

end

game = Minesweeper.new
game.play