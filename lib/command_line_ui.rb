require 'colorize'

class CommandLineUI
  def display_board(board)
    puts "\n#{board.to_s}"
  end

  def error_feedback(msg)
    puts "\n#{msg}\n".colorize :red
  end

  def get_cell_action
    puts 'What would you like to do? (c)lear'
    print ': '
    gets.chomp.downcase
  end

  def get_cell_choice
    print 'Enter row and column coordinates, separated by a comma (eg 1,2): '
      .colorize(:green)

    gets.chomp.downcase
  end

  def player_lost(msg)
    puts "\n#{msg}".colorize :red
    puts 'The game is over and you lost.'.colorize :red
  end
end
