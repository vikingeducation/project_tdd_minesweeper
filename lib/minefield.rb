require './cell.rb'

class Minefield

  attr_reader :board, :width, :height

  def initialize( width, height )
    @width = width
    @height = height
    @board = Array.new(width) { |cell| Array.new(height){ |cell| Cell.new } }
  end

  def place_mines( number_of_mines )
    unless number_of_mines == 0
      mine_x = rand(0..@width-1)
      mine_y = rand(0..@height-1)
      if @board[mine_x][mine_y].is_a_mine
        place_mines( number_of_mines )
      else
        @board[mine_x][mine_y].mine_henshin
        place_mines( number_of_mines - 1)
      end
    end
  end

  # avoiding OOB is annoying
  def place_mine_indicators
    @board.each_with_index do |r, row|
      r.each_with_index do |c, col|
        if !@board[row][col].is_a_mine
          count = 0
          if row-1 >= 0
            count += 1 if col - 1 >= 0 && @board[row-1][col-1].is_a_mine
            count += 1 if @board[row-1][col].is_a_mine
            count += 1 if col + 1 < @board.size && @board[row-1][col+1].is_a_mine
          end
          count += 1 if col - 1 >= 0 && @board[row][col-1].is_a_mine
          count += 1 if col + 1 < @board.size && @board[row][col+1].is_a_mine
          if row + 1 < @board.size
            count += 1 if col - 1 >= 0 && @board[row+1][col-1].is_a_mine
            count += 1 if @board[row+1][col].is_a_mine
            count += 1 if col + 1 < @board.size && @board[row+1][col+1].is_a_mine
          end
          @board[row][col].set_value(count)
          @board[row][col].toggle_visibility
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
        if !cell.check_visibility
          print "❏ "
        else
          print "#{cell.value} "
        end
      end
      print "\n"
    end
  end

end