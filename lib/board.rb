class Board

  attr_reader :board, :flags, :mine_array, :flagged_array

  def initialize(board = nil)
    @board = Array.new(10){Array.new(10)}
    @flags = 15
    @mine_array = []
    @flagged_array = []
  end

  def render
    puts
    puts "# You have #{flags} flags remaining"
    puts
    puts "    0   1   2   3   4   5   6   7   8   9"
    puts "  _______________________________________"
    @board.each_with_index do |row, row_index|
      print "#{row_index} |"
      row.each_with_index do |cell, cell_index|
        cell.nil? ? print("+".center(4)) : print(cell.to_s.center(4))
      end
      puts
    end
  end

  def place_mines
    until @mine_array.length == 9 do
      x = rand(10)
      y = rand(10)
      @mine_array << [x, y] unless @mine_array.include?([x, y])
    end
    print @mine_array
  end

  def place_move(move)
    if has_bomb?(move) == true
      @board[move[0]][move[1]] = :X
      render
      puts "# Oh no, a bomb! You lose."
      exit
    elsif valid_move?(move) && space_available?(move)
      count_adjacent_bombs
      @board[move[0]][move[1]] = ' '
      true
    else
      false
    end
  end

  def neighbors(a, b)
    adjacent_array = []
    (a - 1..a + 1).each do |i|
      (b - 1..b + 1).each do |j|
        adjacent_array << [i, j] if i.between?(0, 9) && j.between?(0, 9)
      end
    end
    adjacent_array.delete([a,b])
    adjacent_array
  end

  def adjacent_bombs(a, b)
    bombs = 0
    neighbor_array = neighbors(a, b)
    neighbor_array.each do |neighbor|
      bombs += 1 if has_bomb?(neighbor)
    end
    bombs
  end

  def count_adjacent_bombs
    @board.each_with_index do |row, row_index|
      row.each_with_index do |col, col_index|
        adjacent_bombs(row_index, col_index)
      end
    end
  end

  def valid_move?(move)
    if (0..9).include?(move[0]) && (0..9).include?(move[1])
      true
    else
      puts "That space doesn't exist."
      false
    end
  end

  def space_available?(move)
    if @board[move[0]][move[1]].nil?
      true
    else
      puts "You have already cleared that space."
      false
    end
  end

  def has_bomb?(move)
    9.times do |i|
      if @mine_array[i] == move
        return true
      end
    end
    false
  end

  def place_flag(move)
    if @flags > 0
      if valid_move?(move) && space_available?(move)
        @board[move[0]][move[1]] = :F
        @flags -= 1
        @flagged_array << [move[0]][move[1]]
        true
      else
        false
      end
    else
      puts "# Sorry, you're out of flags."
    end
  end

end