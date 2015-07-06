require_relative './board.rb'

class Minesweeper
  attr_accessor :board
  
  def initialize
    @board=Board.new

  end

  def game

    loop do

      @board.render

      puts "What move do you want to play?"
      coords = gets.chomp.split(" ")

      if coords == "Q"
        break
      end

      @board.clear(coords[0].to_i, coords[1].to_i)



      break if @board.game_over?

    end

  end

end

# minesweeper = Minesweeper.new
# minesweeper.game



=begin
  
Set up game [Minesweeper]
Set up blank 10x10 board [Board]
Random put 9 mines [Board]
Keep flags, "cleared squares" and bordermines_number [Board]
Square should has states: cleared (show mine or not), flag
Should show remaining flags [Board]


Should change state of a board square [Player]

Set flag at coordinates [Player]
  
=end