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
    puts "#{@board.mine.mine_arr}"
    
    loop do
      coords = @player.get_coordinates
      flag = @player.ask_for_flag

      if(@board.location_valid?(coords))

        puts "board location valid"
        # Check if there are mines adjacent to the cell ref chosen
         mines_near = @board.num_adj_mines(coords)

         puts "number of mines nearby #{mines_near}"

         puts "Do we flag this cell #{flag}"

         # If the user is flagging the cell and has flags remaining  ask for the next input
        if(flag)
          @player.flags -= 1
          puts "Remaining flags #{@player.flags}"
          @board.add_to_board(coords, "F")
        elsif (@board.board_arr[ coords[0] ][ coords[1] ] == "X")
          @game_over = true
        elsif mines_near > 0
          @board.add_to_board(coords, mines_near.to_s)
          @board.update_neighbour_refs(coords)
        else
          @board.add_to_board(coords, "C")
        end

        if(!game_over)
          @board.render
        end
        
      end
      break if check_game_over
    end
  end


  def check_game_over
    if (board.full?)
      puts "You won! You conquered minesweeper!"
      @board.render(true)
      true
    elsif (game_over)
      puts "Sorry you lost! Try again next time!"
      @board.render(true)
      true
    else
      false
    end
  end
end