

class Board

  attr_reader :grid, :mines, :remaining_flags, :mine_array, :remaining_squares

  def initialize
    @grid = Array.new(10) { Array.new(10) }
    @mines = 9
    @mine_array = []
    @remaining_flags = 9
    @remaining_squares = 91
    # @auto_squares = []
  end 

  def display_board
    @grid.each { |row| p row }
    puts "*" * 21
    puts "Remaining squares: #{@remaining_squares}"
    nil
  end

  def set_mines(row, col)
    bomb_array = []

    until bomb_array.length == 10 do 
      bomb_array << [rand(0..9), rand(0..9)]
      bomb_array = (bomb_array - [[row, col]]).uniq
    end

    @mine_array = bomb_array
    nil 
  end

  def open_square(row, col)
    if contains_mine?(row, col)
      @grid[row][col] = :X
      display_board
      puts "BOOM! Sorry, you lost!"
      exit
    elsif mine_count(row, col) > 0 
      @grid[row][col] = mine_count(row, col)
    else
      @grid[row][col] = :O
      @remaining_squares -= 1
    end
    display_board           
  end

  def set_flag(row, col)
    if @remaining_flags < 1
      puts "You're out of flags!"
    else
      @grid[row][col] = :F
      @remaining_flags -= 1  
    end
    display_board
  end

  def valid_square?(row, col)
    @grid[row][col] == nil
  end

  def contains_mine?(row, col)
    @mine_array.include?([row, col])    
  end

  def adjacent_squares(row, col)
    top_three = 3.times.map { |i| [row - 1, col + (i - 1)] }
    bottom_three = 3.times.map { |i| [row + 1, col + (i - 1)] }
    middle_left = [[row, col - 1]]
    middle_right = [[row, col + 1]]

    neighboring_squares = top_three + bottom_three + middle_left  + middle_right
    real_adjacent_squares = neighboring_squares.select { |arr| arr.all? { |num| num >= 0 && num < @grid.length } }
  end

  def mine_count(row, col)
    (adjacent_squares(row, col) & @mine_array).length
  end

  def win?
    @remaining_squares == 0
  end

  def display_win
    puts "Congratulations! You won!" if win?
  end

  def auto_clear(row, col, auto_squares = [])
    if @grid[row][col] == :O 
      unopened_adj_squares = adjacent_squares(row, col).select { |arr| @grid[arr[0]][arr[1]] == nil }
      unopened_adj_squares.each { |arr| open_square(arr[0], arr[1]) }
      auto_squares += unopened_adj_squares.select { |arr| @grid[arr[0]][arr[1]] == :O }
    end
    
    return if auto_squares.length < 1
    auto_squares.each do |arr|
      removed_arr = auto_squares.shift
      auto_clear(removed_arr[0], removed_arr[1], auto_squares)
    end
  end








