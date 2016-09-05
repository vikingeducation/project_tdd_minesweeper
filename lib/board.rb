class Board

  attr_reader :board, :flags

  def initialize(board = nil)
    @board = Array.new(10){Array.new(10)}
    @flags = 15
  end

  def render
    puts
    puts "# You have #{flags} flags remaining"
    puts
    puts "  0   1   2   3   4   5   6   7   8   9"
    @board.each_with_index do |row, row_index|
      print "#{row_index}"
      row.each_with_index do |cell, cell_index|
        cell.nil? ? print("+".center(4)) : print(cell.to_s.center(4))
      end
      puts
    end
  end

  def place_mines
    mine_array = []
    9.times do
      x = rand(10)
      y = rand(10)
      mine_array << [x, y]
    end
    mine_array
  end

  def place_move(move)
    if valid_move?(move) && space_available?(move)
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

  #def clear(move)
  #  @board[move[0]][move[1]] = :C
  #end

  #def flag(move)
    #todo
  #end

end