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
    end

    input

  end

  def get_coordinates

    print "Enter your desired coordinates in the format 1,1: "
    is_valid = false
    until is_valid
      input = gets.chomp.split(",")
      exit if input == ["q"]
      input.map! { |item| item.to_i.-(1) }
      is_valid = is_valid_coordinate?(input)
      print "Sorry! I didn't get that. Try two x,y coordinates as your input: " unless is_valid
    end

    input

  end

  def is_valid_coordinate?(input)

    max_coordinate = [@board.width - 1, @board.height - 1].max
    input.all? { |item| item.between?(0, max_coordinate) }

  end

end