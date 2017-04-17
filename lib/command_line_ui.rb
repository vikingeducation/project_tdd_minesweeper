require 'colorize'

class CommandLineUI
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

  def display_board(board)
    puts "\n#{board.to_s}"
  end
end
