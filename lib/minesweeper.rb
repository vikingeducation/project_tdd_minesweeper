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

      until validate?(coords)
      puts "Invalid move. What move do you want to play?"
      coords = gets.chomp.split(" ")
      end

      case coords[0]
      when "Q"
        break
      when "P"
        @board.clear(coords[1], coords[2])
      when "F"
        @board.flag(coords[1],coords[2])
      end

      break if @board.game_over? || @board.win?

    end

    print_game_finished

  end

  def print_game_finished
    @board.render
    @board.game_over? ? (puts "Dang, you lost...") : (puts "Hooray, you win!")
  end

  def validate?(input)
    return true if input == ["Q"]

    input[1] = input[1].to_i
    input[2] = input[2].to_i

    if (input[0] == "P" || input[0] == "F") &&
        input[1] >= 0  && input[1] < @board.size &&
        input[2] >= 0  && input[2] < @board.size
        return true
    else
      return false
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