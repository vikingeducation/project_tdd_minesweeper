class Board

  attr_reader :board, :flags, :mine_array

  def initialize(board = nil)
    @board = Array.new(10){Array.new(10)}
    @flags = 15
    @mine_array = []
  end

  def render
    puts
    puts "# You have #{flags} flags remaining"
    puts
    puts "  0   1   2   3   4   5   6   7   8   9"
    @board.each_with_index do |row, row_index|
      print "#{row_index}"
      row.each_with_index do |cell, cell_index|
        cell.nil? ? print("[]".center(4)) : print(cell.to_s.center(4))
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
    if loss?(move) == true
      @board[move[0]][move[1]] = :X
      render
      puts "# Oh no, a bomb! You lose."
      exit
    elsif valid_move?(move) && space_available?(move)
      @board[move[0]][move[1]] = ' '
      true
    else
      false
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

  def loss?(move)
    9.times do |i|
      if @mine_array[i] == move
        return true
      end
    end
    false
  end

  #def clear(move)
  #  @board[move[0]][move[1]] = :C
  #end

  #def flag(move)
    #todo
  #end

end