class Board

  attr_reader :game_board, :number_flags

  ALL_COORDS = [[0, 0],[0, 1],[0, 2],[0, 3],[0, 4],[0, 5],[0, 6],[0, 7],[0, 8],[0, 9],
                [1, 0],[1, 1],[1, 2],[1, 3],[1, 4],[1, 5],[1, 6],[1, 7],[1, 8],[1, 9],
                [2, 0],[2, 1],[2, 2],[2, 3],[2, 4],[2, 5],[2, 6],[2, 7],[2, 8],[2, 9],
                [3, 0],[3, 1],[3, 2],[3, 3],[3, 4],[3, 5],[3, 6],[3, 7],[3, 8],[3, 9],
                [4, 0],[4, 1],[4, 2],[4, 3],[4, 4],[4, 5],[4, 6],[4, 7],[4, 8],[4, 9],
                [5, 0],[5, 1],[5, 2],[5, 3],[5, 4],[5, 5],[5, 6],[5, 7],[5, 8],[5, 9],
                [6, 0],[6, 1],[6, 2],[6, 3],[6, 4],[6, 5],[6, 6],[6, 7],[6, 8],[6, 9],
                [7, 0],[7, 1],[7, 2],[7, 3],[7, 4],[7, 5],[7, 6],[7, 7],[7, 8],[7, 9],
                [8, 0],[8, 1],[8, 2],[8, 3],[8, 4],[8, 5],[8, 6],[8, 7],[8, 8],[8, 9],
                [9, 0],[9, 1],[9, 2],[9, 3],[9, 4],[9, 5],[9, 6],[9, 7],[9, 8],[9, 9]]

  def initialize(board = Array.new(10).map{ |x| Array.new(10, "-")})
    @game_board = board
    @number_of_flags = 9
    @number_of_mines = 9
    @flag = "$"
    @mine = "*"
  end

  # renders board to terminal
  def render_board
    puts "Number of Mines: #{@number_of_mines}"
    puts "Remaining Flags: #{@number_of_flags}"
    puts "  0 1 2 3 4 5 6 7 8 9"
    @game_board.each.with_index do |row, index|
      print "#{index} #{row}"
      puts
    end
  end

  # randomly places nine mines
  def hide_mines
    mines = Array.new
    (1..9).each do
      mines << [rand(0..9), rand(0..9)]
    end
    mines.uniq!
    if mines.length < 9
      mines << [rand(0..9), rand(0..9)]
    end
    mines
  end

  # once you have coords from user - changes square to cleared, mine, number accordingly
  def click_square(coords, mines)
    x,y,z = coords
  case z
    when 1
      if mines.include?([x, y])
        reveal_mines(mines)
      elsif near_mines(mines).values.flatten(1).include?([x, y])
        reveal_number([x, y], mines)
      else
        clear_group([x, y], mines)
      end
    when 2
      if @game_board[x][y] == "$"
        remove_flag([x, y])
      else
        place_flag([x, y])
      end
    end
  end


  def place_flag(coords)
    if @number_of_flags > 0
      @game_board[coords[0]][coords[1]] = @flag
      @number_of_flags -= 1
      @number_of_mines -= 1
    else
      raise "You are out of flags!"
    end
  end


  def remove_flag(coords)
    x,y = coords
    if @number_of_flags == 9
      raise "You have no flags to remove!"
    end
    case @game_board[x][y]
    when "$"
      @game_board[x][y] = "-"
      @number_of_flags += 1
      @number_of_mines += 1
    when "-"
      raise "There is no flag in that square!"
    when " "
      raise "Square cleared!"
    end
  end

  # checks winning game condition
  def win_game?(mines)
    remaining_uncleared_squares.sort == mines.sort
  end

  # gives you coordinates of all squares that have not been cleared yet
  def remaining_uncleared_squares
    coords = []
    @game_board.flat_map.with_index do |row, row_index|
      row.each_index.select {|i| row[i] == "-" || row[i] == @flag }.map do |col_index|
        coords << [row_index, col_index]
      end
    end
    coords
  end

  # finds all squares near mines
  def near_mines(mines)
    near_mines_arr = []
    final = []
    mines.each do |coords|
      near_mines_arr << get_directions(coords)
    end
    near_mines_arr.each do |hash|
      final << hash.values.delete_if { |arr| arr[0] < 0 || arr[1] < 0 || arr[0] > 9 || arr[1] > 9 }
    end
    final.flatten!(1)
    touching_mines(final)
  end

  # finds all emtpy squares on board after mines and numbers have been determined
  def empty_squares(mines)
    nm = near_mines(mines).values.flatten(1)
    empty_squares = ALL_COORDS - nm - mines
    empty_squares
  end


  # creates groups of squares that can all be cleared at once (empty squares touching eachother and one numbered square)
  def clear_group(coords, mines)
    nearmines = near_mines(mines)
    @game_board[coords[0]][coords[1]] = " "
    empty = (get_directions(coords).delete_if { |key, val| val[0] < 0 || val[0] > 9 || val[1] < 0 || val[1] > 9 || mines.include?(val) }).values
    empty.each do |coord|
      x,y = coord
      if nearmines.values.flatten(1).include?(coord)
        (1..8).each do |i|
          if nearmines[i].include?(coord)
            @gameboard[x][y] = nearmines[i].to_s
          end
        end
      else
        @game_board[x][y] = " "
        clear_group(coord, mines)
      end
    end
  end


  # checks to see if the game was lost
  def lose_game?
    lose = []
    index = 0
    while index < 9
      if @game_board[index].include?("*")
        lose << true
      end
      index += 1
    end
    if lose.include?(true)
      true
    else
      false
    end
  end

  private

  # reveals all mines if one is cleared
  def reveal_mines(mines)
    mines.each do |arr|
      @game_board[arr[0]][arr[1]] = "*"
    end
  end

  # helper method - takes all squares touching mines and organizes them by how many mines it is touching
  def touching_mines(array)
    one = array.select { |element| array.count(element) == 1 }
    two = array.select { |element| array.count(element) == 2 }.uniq
    three = array.select { |element| array.count(element) == 3 }.uniq
    four = array.select { |element| array.count(element) == 4 }.uniq
    five = array.select { |element| array.count(element) == 5 }.uniq
    six = array.select { |element| array.count(element) == 6 }.uniq
    seven = array.select { |element| array.count(element) == 7 }.uniq
    eight = array.select { |element| array.count(element) == 8 }.uniq
    touching_mines = { 1 => one, 2 => two, 3 => three, 4 => four, 5 => five, 6 => six, 7 => seven, 8 => eight }
    touching_mines
  end

  # helper method - find coords all squares touching a particular square(coord pair)
  def get_directions(array)
    directions = { :up => [(array[0] - 1), array[1]], :upRight => [(array[0] - 1), (array[1] + 1)], :right => [array[0], (array[1] + 1)],
                   :downRight => [(array[0] + 1), (array[1] + 1)], :down => [(array[0] + 1), array[1]], :downLeft => [(array[0] + 1), (array[1] - 1)],
                   :left => [array[0], (array[1] - 1)], :upLeft => [(array[0] - 1), (array[1] - 1)] }
  end

  # helper method - reveals number if square is touching a mine
  def reveal_number(coords, mines)
    m = near_mines(mines)
    (1..8).each do |i|
      if m[i].include?(coords)
        @game_board[coords[0]][coords[1]] = i.to_s
      end
    end
  end

end
