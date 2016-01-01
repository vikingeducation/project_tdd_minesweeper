class Board
  def initialize
    @display_grid = Array.new(10){Array.new(10){"-"}}
    @flags = 9
    @answer_grid = Array.new(10){Array.new(10)}
  end

  def render
    @answer_grid.each do |y|
      puts ""
      y.each do |x|
        print x
      end
    end
  end

  def place_random_mines
    mines_placed = 0
    until mines_placed == 9
      y = rand(10)
      x = rand(10)
      until space_is_nil?(x, y)
        y = rand(10)
        x = rand(10)
      end
      @answer_grid[y][x] = 'm'
      mines_placed += 1
    end
  end

  def space_is_nil?(y, x)
    @answer_grid[y][x] == nil
  end

  def set_up_rest_of_answer_grid
    @answer_grid.each_with_index do |y, y_index|
      y.each_with_index do |x, x_index|
        if x == nil
          @answer_grid[y_index][x_index] = how_many_mines_touching(y_index, x_index)
        end
      end
    end
  end

  def how_many_mines_touching(y_index, x_index)
    mines_touching = 0
    # Check above and to the left
    mines_touching += 1 if (y_index > 0) && (x_index > 0) && (@answer_grid[y_index - 1][x_index - 1] == 'm')
    # Check above
    mines_touching += 1 if (y_index > 0) && (@answer_grid[y_index - 1][x_index] == 'm')
    # Check above and to the right
    mines_touching += 1 if (y_index > 0) && (x_index < 9) && (@answer_grid[y_index - 1][x_index + 1] == 'm')
    # Check to the right
    mines_touching += 1 if (x_index < 9) && (@answer_grid[y_index][x_index + 1] == 'm')
    # Check to the right and below
    mines_touching += 1 if (x_index < 9) &&  (y_index < 9) && (@answer_grid[y_index + 1][x_index + 1] == 'm')
    # Check below
    mines_touching += 1 if (y_index < 9) && (@answer_grid[y_index + 1][x_index] == 'm')
    # Check below and to the left
    mines_touching += 1 if (y_index < 9) && (x_index > 0) && (@answer_grid[y_index + 1][x_index -1] == 'm')
    # Check to the left
    mines_touching += 1 if (x_index > 0) && (@answer_grid[y_index][x_index - 1] == 'm')
    mines_touching
  end

  def win?
    @display_grid == @answer_grid
  end

  def lose?
    @display_grid.each do |y|
      y.each do |spot|
        return true if spot == '!'
      end
    end
    false
  end

  def place_players_move(move)
    move_split = move.split('')
    if move_split[0] == 'f'
      add_or_remove_flag(move_split[1], move_split[2])
    else
      open_on_display_grid(move_split[1], move_split[2])
    end
  end

  def add_or_remove_flag(y_index, x_index)
    if @display_grid[y_index][x_index] == 'f'
      @display_grid[y_index][x_index] = '-'
      @flags += 1
    elsif @display_grid[y_index][x_index] == '-'
      @display_grid[y_index][x_index] = 'f'
      @flags -= 1
    end
  end

  def open_on_display_grid(y_index, x_index)
    true
  end
end