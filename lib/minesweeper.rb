require_relative './board.rb'

class Minesweeper
  attr_accessor :board

  def initialize
    @board=Board.new

  end

  def game

    if File.exist?("my_game.txt")
      ask_to_load_game
    end

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
        @board.clear(coords[2], coords[1])
      when "F"
        @board.flag(coords[2],coords[1])
      when "S"
        @board.save("my_game.txt", "w")
      end

      break if @board.game_over? || @board.win?

    end

    print_game_finished

  end

  def ask_to_load_game
    puts "Type 'Y' to load 'my_game.txt'."
    choice = gets.chomp.downcase

    if choice == "y"
      @board.load("my_game.txt")
    end
  end

  def print_game_finished
    if @board.win?
      @board.render
      puts "Hooray, you win!"
    else
      @board.render_game_over
      puts "Better luck next time..."
    end
  end

  def validate?(input)
    return true if input == ["Q"] || input == ["S"]
    input[0] = input[0].upcase

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

minesweeper = Minesweeper.new
minesweeper.game