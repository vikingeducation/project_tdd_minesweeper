require 'pry'
require './board.rb'
require './cell.rb'

class Minesweeper
  def initialize
    @game_board = Board.new
    @player = Player.new
    @player_wants_to_continue = true
    play
  end

  def play
    welcome
    while @player_wants_to_continue
      @game_board.select_coordinate(@player.get_user_input)

      @game_board.render
      if player_has_lost? || player_has_won?
        exit
      end
    end
  end

  def welcome
    puts "Welcome to minesweeper! For each move enter your coordinates array style, (i.e. type '5,5') if you want to quit type 'Q'! If you want to flag a mine, type 'F' first, then coordinates. Same method to unflag. Good luck!"
  end

  def player_has_lost?
    if @game_board.check_loss?
      puts "Sorry man, you lose!"
      return true
    end
  end

  def player_has_won?
    if @game_board.check_victory?
      puts "Congratulations! You win!"
      return true
    end
  end
end

class Player
  def get_user_input
    print ("Enter your move: ")
    player_choice = gets.chomp
    if player_choice.upcase == "Q"
      @player_wants_to_continue = false
      exit
    end
    if player_choice == "F"
      return player_choice
    else
      player_choice = player_choice.split(",").map(&:to_i)
      return player_choice
    end
  end
end


schwad = Minesweeper.new
schwad
# myBoard = Board.new
# # myBoard.render
# myBoard.place_mines([0,3,20,40,55,33,34,35,60,70])
# myBoard.set_all_cell_adjacent_mines
# # myBoard.set_all_cell_adjacent_mines
# myBoard.autoclear(7,5)

# myBoard.render



