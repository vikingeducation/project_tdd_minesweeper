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
      current_tile.is_cleared = true
    else
      if current_tile.is_flag = false
        current_tile.is_flag = true
      else
        current_tile.is_flag = false
      end
    end
    current_tile

  end

  def get_move_type

    print "Would you like to place/remove a [f]lag or [c]lear a tile? "
    input = gets.chomp.downcase

    until ["f", "c"].include?(input)
      print "Sorry! I didn't get that. Try 'f' or 'c' as your input:  "
      input = gets.chomp.downcase
    end

    input

  end

  def get_coordinates

    print "Enter your desired coordinates in the format 0,0: "
    input = gets.chomp.split(",")
    input.map! { |item| item.to_i }

    until is_valid_coordinate?(input)
      print "Sorry! I didn't get that. Try two numbers as your input: "
      input = gets.chomp.split(",")
    end

    input

  end

  def is_valid_coordinate?(input)

    max_coordinate = [@board.width, @board.height].max
    input.all? { |item| item.between?(0, max_coordinate) }

  end

end