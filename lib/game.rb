require_relative 'minesweeper'

class Game
  attr_reader :board

  def initialize
    puts "Input size of board or enter for default: "
    rows = gets.chomp.to_i
    rows = 10 unless rows > 0
    puts "Input number of mines or enter for default: "
    mines = gets.strip.to_i
    mines = (rows * rows * 0.09).floor unless mines > 0
    @board = Minesweeper.new(rows, rows, mines)
  end

  def play
    @board.print_instructions
    begin
      @board.turn until @board.game_over?
    rescue Interrupt
      puts "\nThanks for playing!"
    end
  end
end
