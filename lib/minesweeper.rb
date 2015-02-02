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
    while player_wants_to_continue
      game_board.select_coordinate(get_user_input)
      exit if player_has_lost || player_has_won
    end
  end

  def player_has_lost?
    #Condition
    puts "Congratulations!"
  end

  def player_has_won?
    #Condition
    puts "Congratulations!"
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
    player_choice = player_choice.split(",").map(&:to_i)
  end
end



myBoard = Board.new
# myBoard.render
myBoard.place_mines([0,3,20,40,55,33,34,35,60,70])
myBoard.set_all_cell_adjacent_mines
# myBoard.set_all_cell_adjacent_mines
myBoard.autoclear(7,5)

myBoard.render



