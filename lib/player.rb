class Player

  def initialize(board)

    @board = board

  end

  def get_move

    type = get_move_type
    coords = get_coordinates
    perform_move(type, coords)

  end

  def perform_move(type, coords)

    current_tile = @board.game_state[coords[0]][coords[1]]
    if type == "c"
      if current_tile.is_cleared
        puts "You already cleared this tile"
      elsif current_tile.is_flag
        puts "You must remove the flag before clearing a tile"
      else
        current_tile.is_cleared = true
        @board.clear_nearby(current_tile) if current_tile.mines_nearby == 0 && !current_tile.is_mine
      end
    else
      if current_tile.is_flag
        current_tile.is_flag = false
      else
        if current_tile.is_cleared
          puts "No need to place a flag here ;)"
        else
          current_tile.is_flag = true
        end
      end
    end
    current_tile

  end

  def get_move_type

    print "Would you like to place/remove a [f]lag or [c]lear a tile? "
    input = gets.chomp.downcase
    exit if input == "q"

    until ["f", "c"].include?(input)
      print "Sorry! I didn't get that. Try 'f' or 'c' as your input:  "
      input = gets.chomp.downcase
      exit if input == "q"
    end

    input

  end

  def get_coordinates

    print "Enter your desired coordinates in the format 1,1: "
    is_valid = false
    until is_valid
      input = gets.chomp.split(",")
      exit if input == ["q"]
      is_valid = is_valid_input?(input)
      print "Sorry! I didn't get that. Try two x,y coordinates as your input: " unless is_valid
    end

    input

  end


  def is_valid_input?(input)

    return false if input.length != 2
    input.map! do |item|
      (item.to_i) - 1
    end

    is_valid_coordinate?(input)

  end

  def is_valid_coordinate?(input)

    input[0].between?(0, @board.width-1) && input[1].between?(0, @board.height-1)

  end

end