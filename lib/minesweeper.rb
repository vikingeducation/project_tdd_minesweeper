require_relative 'minefield'
require_relative 'turn'

class Minesweeper
  def initialize
    @mines = Minefield.new
    intro
    loop do
      print_game_board
      take_a_turn
      check_for_game_end
    end
  end

  private

  def intro
    print "welcome to\nMINESWEEPER\n\nCOMMANDS:\n'C' to clear\n'A' to auto-clear\n'F' to flag\n'U' to un-flag\nThe ⚑ shows you how many flags are left"
  end

  def print_game_board
    puts "⚑ #{@mines.unflagged_mines}"
    @mines.render
  end

  def take_a_turn
    turn = Turn.new
    @mines.take_turn(turn.message)
  end

  def check_for_game_end
    game_over_sequence if @mines.game_over?
  end

  def game_over_sequence
    if @mines.won?
      winning_sequence
    else
      losing_sequence
    end
    exit
  end

  def winning_sequence
    @mines.flag_remaining_mines
    print_game_board
    puts "CONGRATULATIONS!"
  end

  def losing_sequence
    @mines.blow_up_board
    print_game_board
    puts "BOOM! YOU LOST."
  end
end