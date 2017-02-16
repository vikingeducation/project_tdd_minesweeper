# Running of the Game

require_relative 'board'
require_relative 'player'

class Game

attr_accessor :player, :board, :game_over

  def initialize
    @board = Board.new
    @player = Player.new
    @game_over = false
  end

  def play

    @board.add_mines_to_board(9)
    
    loop do
      coords = @player.get_coordinates
      flag = @player.ask_for_flag

      if(@board.location_valid?(coords))
        # Check if there are mines adjacent to the cell ref chosen
         mines_near = @board.num_adj_mines(coords)

        if(flag)
          process_flag(coords)
        elsif (@board.board_arr[ coords[0] ][ coords[1] ] == "X")
          @game_over = true
        elsif mines_near > 0
          process_adj_mines(coords, mines_near)
        else
          process_clear_cell(coords)
        end
        show_board
      end

      break if win? || @game_over
    end
  end

  def process_clear_cell(coords)
    @board.add_to_board(coords, "C")
    @board.update_clear_neighbours(coords)
  end

  def process_flag(coords)
    @player.flags -= 1
    puts "Remaining flags #{@player.flags}"
    @board.add_to_board(coords, "F")
  end

  def process_adj_mines(coords, mines_near)
    @board.add_to_board(coords, mines_near.to_s)
  end

  def win?
    @board.full?
  end

  def final_user_output
    if win? 
      puts "You won! You conquered minesweeper!"
    elsif @game_over
      puts "Sorry you lost! Try again next time!"
    end
  end

  def show_board
    show_mines = win? || game_over
    @board.render(show_mines)
  end
end