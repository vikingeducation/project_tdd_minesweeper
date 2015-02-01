require_relative 'minefield'
require_relative 'turn'

class Minesweeper
  def initialize
    @mines = Minefield.new
    print "welcome to\nMINESWEEPER\n\nCOMMANDS:\n'C' to clear\n'A' to auto-clear\n'F' to flag\n'U' to un-flag\nThe ⚑ shows you how many flags are left"
    loop do
      print_game_board
      turn = Turn.new
      @mines.take_turn(turn.message)
      game_over_sequence if @mines.game_over?
    end
  end

  def print_game_board
    puts "⚑ #{@mines.unflagged_mines}"
    @mines.render
  end

  def game_over_sequence
    if @mines.won?
      @mines.flag_remaining_mines
      print_game_board
      puts "CONGRATULATIONS!"
    elsif @mines.lost?
      @mines.blow_up_board
      print_game_board
      puts "BOOM! YOU LOST."
    end
    exit
  end
end