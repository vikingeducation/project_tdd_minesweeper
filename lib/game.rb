# Running of the Game
class Game

attr_accessor :player, :board, :game_over

  def initialize
    @player = Player.new
    @board = Board.new
    # @mine = Mine.new
    @game_over = false
  end

  def play
    loop do
      coords = @player.get_coordinates
      flag = @player.ask_for_flag

      @board.add_mines_to_board(9)

      if(location_valid?(coords))
        if(flag)
          @player.flags_remaining -= 1
          @board.add_to_board(coords, "F")
        elsif @board[coords[0]][coords[1]] = "X"
          @game_over = true
        elsif @board.getNumberAdjacentMines(coords) > 0

# Follow through this part - decide where to put the mine code
          num = @board.getNumberAdjacentMines(coords)
          @board.add_to_board(coords, num.to_s)
          @board.update_neighbour_refs(coords)
        else
          @board.add_to_board(coords, "C")
        end
      end


      while !@board.full?) || !@game_over
    end
  end

end