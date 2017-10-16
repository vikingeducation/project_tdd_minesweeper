require_relative 'instructions'
require_relative 'board'

class Game

  include Instructions

  def initialize
    @play_again = true
  end

  def play
    render_welcome
    render_instructions
    @board = Board.new
    while @play_again == true
      play_round
    end
    exit_game
  end

  def play_round
    @board.render
    place_flag? ? place_flag : try_cell
  end

  def play_again?
    puts "Play again? y | n"
    response = gets.chomp.downcase
    return false unless response == 'y'
  end

  def has_won?
    @board.all_cleared?
  end

  def place_flag?
    puts "Do you want to place a flag?  'y' or 'n'"
    response = gets.chomp.downcase
    case response
      when 'q' then exit_game
      when 'y' then true
      else false
    end
  end

  def place_flag
    cell = request_cell
    cell.place_flag
    @board.remaining_flags -= 1
    @board.refresh_display_headers
  end

  def try_cell
    cell = request_cell
    cell.reveal
    @board.refresh_display_headers

    return render_lose if cell.losing_choice?
    return render_win if has_won?
  end

  def request_cell
    row = request_row
    column = request_column
    @board.grid[row][column +1]
  end

  def request_row
    puts "Enter row number:"
    check_for_exit(gets.chomp)
  end

  def request_column
    puts "Enter column number:"
    check_for_exit(gets.chomp)
  end

  def check_for_exit(input)
    input.downcase == 'q' ? exit_game : input.to_i
  end

  def render_lose
    @board.render
    puts 'You hit a mine, so you lose. Game Over.'
    exit_game
  end

  def render_win
    puts 'Congratulations! You WIN!'
    @play_again = false
    exit_game
  end

  def exit_game
    puts 'Bye!'
    exit
  end

end
