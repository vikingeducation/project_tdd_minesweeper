class Minefield

  attr_reader :board, :width, :height

  def initialize( width, height )
    @width = width
    @height = height
    @board = Array.new(width) { |cell| Array.new(height){ |cell| 0 } }
  end

  def place_mines( number_of_mines )
    unless number_of_mines == 0
      mine_x = rand(0..@width-1)
      mine_y = rand(0..@height-1)
      if @board[mine_x][mine_y] == 4
        place_mines( number_of_mines )
      else
        @board[mine_x][mine_y] = 4
        place_mines( number_of_mines - 1)
      end
    end
  end

  # avoiding OOB is annoying
  def place_mine_indicators
    valid_moves = [ [-1, 0], [-1, -1], [0, -1], [1, -1], [1,0], [1,1], [0,1], [-1,1]]
    @board.each_with_index do |r, row|
      r.each_with_index do |c, col|
        if @board[row][col] != 4
          count = 0
          if row-1 >= 0
            count += 1 if col - 1 >= 0 && @board[row-1][col-1] == 4
            count += 1 if @board[row-1][col] == 4
            count += 1 if col + 1 < @board.size && @board[row-1][col+1] == 4
          end
          count += 1 if col - 1 >= 0 && @board[row][col-1] == 4
          count += 1 if col + 1 < @board.size && @board[row][col+1] == 4
          if row + 1 < @board.size
            count += 1 if col - 1 >= 0 && @board[row+1][col-1] == 4
            count += 1 if @board[row+1][col] == 4
            count += 1 if col + 1 < @board.size && @board[row+1][col+1] == 4
          end
          @board[row][col] = count
        end
      end
    end
  end

  def make_move( row, col )

  end

  def render
    puts ""
    @board.each do |row|
      row.each do |cell|
        if cell == 0
          print "❏ "
        else
          print "#{cell} "
        end
      end
      print "\n"
    end
  end

end