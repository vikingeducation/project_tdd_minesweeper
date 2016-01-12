require 'board'

class Minesweeper
  def initialize
    @board = nil
    @move_counter = 0
  end

  private_class_method :new

  def self.setup_game
    new
  end

  def print_intro
    puts "\nWelcome to Minesweeper.\n"
  end

  def play
    print_intro
    get_game_params
  end

  def get_game_params
    puts "\nEnter Height, Width, and Number of Mines as integers with a space in between:\n"
    puts "\nExample: \"10 10 5\" or \"4 6 3\""
    input = gets.chomp.split(" ").map(&:to_i)

  end

end
#initialize game

#print intro
#ask user for height, width and number of mines
#valid user input for those parameters
#initialize board based on user input

#start game loop

  #print board state (the board, how many mines exist, maybe time)

  #check if there are empty valid squares to move on

  #ask user for coordinates

  #process the move
    #checks if input argument (i.e. the move) is valid
      #squares that have already been cleared are not valid
      #coords that are out of bounds are not valid
    #if the square happens to be empty, clear the appropriate squares
    #else if coord contains a mine, print "YOU LOSE" and exit game loop

#end game loop
