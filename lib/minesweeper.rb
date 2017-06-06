require_relative 'player'
require_relative 'board'
# MineSweeper class handles main game actions (game loop)
class MineSweeper

  attr_reader :game_board

  def initialize(player = Player.new, board = Board.new)
    @player = player
    @game_board = board
  end


  def play_game
    self.instructions
    mines = @game_board.hide_mines
     loop do
       @game_board.render_board
       coords = @player.click_selection
       @game_board.click_square(coords, mines)
       win?(mines) || lose? ? play_again? : next
     end
  end


  def instructions
    puts "Welcome to MineSweeper!"
    puts "Your goal is to clear all squares that do not contain a mine"
    puts "There are nine mines total"
    puts "If you clear a mine, you loose"
    puts "If you cleared the whole board except the mines, or accurately place a flag on all the mines, you win!"
    puts "Please enter the square you would like to clear with 'x,y,z' coordinates"
    puts "Where x = row, y = column, z = 1 to clear a square, 2 to place or remove a flag"
  end


  def win?(mines)
    @game_board.win_game?(mines)
  end


  def lose?
    if @game_board.lose_game?
      puts "Sorry you lose!"
      play_again?
    end
  end

  def play_again?
    puts "Would you like to play again? 'y/n'"
    answer = gets.chomp.downcase
    if answer == "y"
      play_game
    else
      exit
    end
  end


end
