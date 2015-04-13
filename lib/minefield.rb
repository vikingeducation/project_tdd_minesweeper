require_relative './cell.rb'

class Minefield
  attr_reader :board, :width, :height

  def initialize(width, height)
    @width = width
    @height = height
    @board = Array.new(width) { |cell| Array.new(height) { |cell| Cell.new } }
  end

  def place_mines(number_of_mines)
    unless number_of_mines == 0
      mine_x = rand(0..@width - 1)
      mine_y = rand(0..@height - 1)
      if @board[mine_x][mine_y].is_a_mine
        place_mines(number_of_mines)
      else
        @board[mine_x][mine_y].mine_henshin
        place_mines(number_of_mines - 1)
      end
    end
  end

  # avoiding OOB is annoying
  def place_mine_indicators
    @board.each_with_index do |r, row|
      r.each_with_index do |_c, col|
        unless @board[row][col].is_a_mine
          count = 0
          if row - 1 >= 0
            count += 1 if col - 1 >= 0 && @board[row - 1][col - 1].is_a_mine
            count += 1 if @board[row - 1][col].is_a_mine
            count += 1 if col + 1 < @board.size && @board[row - 1][col + 1].is_a_mine
          end
          count += 1 if col - 1 >= 0 && @board[row][col - 1].is_a_mine
          count += 1 if col + 1 < @board.size && @board[row][col + 1].is_a_mine
          if row + 1 < @board.size
            count += 1 if col - 1 >= 0 && @board[row + 1][col - 1].is_a_mine
            count += 1 if @board[row + 1][col].is_a_mine
            count += 1 if col + 1 < @board.size && @board[row + 1][col + 1].is_a_mine
          end
          @board[row][col].set_value(count)
        end
      end
    end
  end

  # this can probably be broken up further
  def make_move(move_array)
    if move_array == ['F']
      puts ''
      puts 'Enter flag row, col: '
      print '> '

      begin
        flag_coord = gets.chomp.strip.split(',').map(&:to_i)
        if !in_bounds?(flag_coord[0], flag_coord[1])
          raise ArgumentError, 'Entered OOB flag coordinates!'
        else
          @board[flag_coord[0]][flag_coord[1]].toggle_flag
        end
        rescue => e
        puts e
      end
    else
      if !in_bounds?(move_array[0], move_array[1])
        puts 'Entered OOB coordinates!'
      else
        move = @board[move_array[0]][move_array[1]]
        move.toggle_visibility
        if move.is_a_mine?
          render
          puts 'You lose!'
          exit
        end
        autoclear(move_array[0], move_array[1]) if move.adjacent_mines == 0
      end
    end
  end

  def won?
    @board.flatten.each do |cell|
      return false if !cell.is_visible? && !cell.is_a_mine?
    end
    true
  end

  def in_bounds?(row, col)
    if row < 0 || col < 0
      false
    elsif row > @width - 1 || col > @width - 1
      false
    elsif row > @height - 1 || col > height - 1
      false
    else
      true
    end
  end

  def set_all_cell_adjacent_mines
    @board.each_with_index do |_row, row_index|
      @board[row_index].each_with_index do |_column, column_index|
        set_cell_adjacent_mines(row_index, column_index)
      end
    end
  end

  def set_cell_adjacent_mines(row, column)
    around_array = [-1, 0, 1]
    around_array.each do |row_offset|
      around_array.each do |column_offset|
        if in_bounds?(row + row_offset, column + column_offset) &&
           @board[row + row_offset][column + column_offset].is_a_mine?
          next if row_offset == row && column_offset == column
          @board[row][column].adjacent_mines += 1
        end
      end
    end
  end

  def autoclear(row, column)
    around_array = [-1, 0, 1]
    around_array.each do |row_offset|
      around_array.each do |column_offset|
        if in_bounds?(row + row_offset, column + column_offset) &&
           !@board[row + row_offset][column + column_offset].is_a_mine?
          next if row_offset == row && column_offset == column
          # no recursion if the adjacent space is next to a mine
          if @board[row + row_offset][column + column_offset].adjacent_mines > 0
            @board[row + row_offset][column + column_offset].toggle_visibility
          end
          # recursion if the adjacent space is not next to any mines
          if @board[row + row_offset][column + column_offset].adjacent_mines == 0 &&
             !@board[row + row_offset][column + column_offset].is_visible?
            @board[row + row_offset][column + column_offset].toggle_visibility
            autoclear(row + row_offset, column + column_offset)
          end
        end
      end
    end
  end

  def render
    puts ''
    @board.each do |row|
      row.each do |cell|
        print "#{cell.icon} "
      end
      print "\n"
    end
  end
end
