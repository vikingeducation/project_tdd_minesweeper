require_relative 'player'
require_relative 'board'

class Minesweeper
  def initialize
    
  end

  def play
    display_welcome
    display_instructions
    name = ask_for_name
    @player = Player.new(name)
    if play_default_board?
      prompt_to_start_game
      @board = Board.new
    else
      width = ask_for_width
      mines = ask_for_mine_ct
      prompt_to_start_game
      begin 
        @board = Board.new(width: width, mines: mines)
      rescue
        max_mines = (width**2 * 0.3).to_int
        puts 'Too many mines!'
        puts "Mine count has been set to #{max_mines}."
        @board = Board.new(width: width, mines: max_mines)
      end
    end
    display_game_is_starting
    @board.render
    game_status = @board.return_board_status
    while game_status == 'ongoing'
      move = @player.get_move
      until @board.valid_move?(move) 
        exit_program if move == 'q'
        puts 'Invalid move!'
        move = @player.get_move
      end
      @board.update_board!(move)
      @board.render
      game_status = @board.return_board_status
    end
    display_game_over_message(game_status)
  end

  private

  def play_default_board?
    puts "Do you want to play the default board (10x10, 9 mines)? (y|n)"
    input = gets.chomp
    until input == 'y' || input == 'n'
      exit_program if input == 'q'
      puts "Please enter 'y' or 'n'."
      input = gets.chomp
    end
    input == 'y' ? true : false
  end

  def ask_for_name
    puts "Please enter a nickname:" 
    input = gets.chomp
    until (3..12).include?(input.length)
       exit_program if input == 'q'
       puts "Nickname must be between 3-12 characters long!"
       input = gets.chomp
    end
    input
  end

  def ask_for_width
    puts "Please enter a custom board width (>= 10):" 
    input = gets.chomp
    until input.to_i >= 10 
      exit_program if input == 'q'
      puts "Width must be >= 10!"
      input = gets.chomp
    end
    input.to_i
  end

  def ask_for_mine_ct
    puts "Please enter a mine count (< 30% of area of board):" 
    input = gets.chomp
    until input.to_i > 0 
      exit_program if input == 'q'
      puts "You must have at least 1 mine!"
      input = gets.chomp
    end
    input.to_i
  end

  def display_welcome
    puts "Welcome to Minesweeper!"
    puts "-----------------------"
    puts "You can quit the program at anytime by entering 'q'."
    puts
  end

  def display_instructions 
    puts "Instructions:"
    puts "> Clear squares by entering moves in the format '# # a',"
    puts "where the first number corresponds to the x position of your move,"
    puts "the second number corresponds to the y position of your move, and"
    puts "a corresponds to your action (c to clear, f to flag, u to unflag)."
    puts "> Example: '4 4 c' indicates a move to clear the square at [4, 4]"
    puts "> Uncover a mine, and you lose!"
    puts "> Uncover an empty square or a number, and you keep playing!"
    puts "The number tells you how many mines lay hidden in adjacent squares."
    puts
  end

  def prompt_to_start_game
    puts
    print "Hit enter to start the game > "
    exit_program if gets.chomp == 'q'
  end

  def display_game_is_starting
    puts
    puts "Game is starting now..."
  end

  def display_game_over_message(game_status)
    case game_status
    when 'won'
      puts "Congratulations #{@player.name}!"
      puts "You have won with a time of #{@board.win_time} seconds."
    when 'lost'
      puts 'You hit a mine!'
      puts 'Game over!'
    end
  end

  def exit_program
    puts "Thanks for playing!"
    puts "Exiting..."
    exit
  end
end