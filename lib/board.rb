
class Board
  attr_accessor :board
  def initialize(size=10)
    @size = size
    @board = Array.new(@size) {Array.new(@size){Cell.new}}
    place_mines(generate_mines)
    set_all_cell_adjacent_mines

  end

  def generate_mines
    (0..((@size*@size)-1)).to_a.sample(@size)
  end

  def place_mines mine_locations
    mine_locations.each do |x|
      tens = x / 10
      ones = x % 10
      @board[tens][ones].mine = true
    end
  end

  # def initialize_mines
  #   place_mines(generate_mines)
  # end

  def set_all_cell_adjacent_mines
    @board.each_with_index do |row, row_index|
      @board[row_index].each_with_index do |column, column_index|
        set_cell_adjacent_mines(row_index,column_index)
      end
    end
  end

  def is_mine? (row, column)
    @board[row][column].mine
  end

  def set_cell_adjacent_mines(row, column)
    around_array = [-1, 0, 1]
    around_array.each do |row_offset|
      around_array.each do |column_offset|
        if (is_in_bound?(row+row_offset,column+column_offset) && is_mine?(row+row_offset,column+column_offset))
          next if row_offset == row && column_offset == column 
          @board[row][column].adjacent_mines += 1
        end
      end
    end
  end

  def is_in_bound? (row_index, column_index)
    if (row_index < 0 || column_index < 0)
      return false
    elsif (row_index > @size-1 || column_index > @size-1)
      return false
    else
      return true
    end
  end

  def is_empty?(row,col)
    @board[row][col].mine == false
  end

  def autoclear(row, column)
    around_array = [-1, 0, 1]
    around_array.each do |row_offset|
      around_array.each do |column_offset|
        if (is_in_bound?(row+row_offset,column+column_offset) && is_empty?(row+row_offset,column+column_offset))
          next if row_offset == row && column_offset == column 
          if @board[row+row_offset][column+column_offset].adjacent_mines > 0
            @board[row+row_offset][column+column_offset].hidden = false
          end
          #recursion zone
          if @board[row+row_offset][column+column_offset].adjacent_mines == 0 && @board[row+row_offset][column+column_offset].hidden == true
            @board[row+row_offset][column+column_offset].hidden = false
            self.autoclear(row+row_offset,column+column_offset)
          end
        end
      end
    end
  end

  def check_victory?
    @board.flatten.each do |cell|
      if cell.mine == false && cell.hidden == true
        return false
      end
    end
    return true
  end


  def check_loss?
    @board.flatten.each do |cell|
      if cell.mine == true && cell.hidden == false
        return true
      end      
    end
    return false
  end
  #magic in here
  def select_coordinate(user_ary)

    if user_ary == "F"
      print "Enter flag coordinates:  "
      flag_coordinates = gets.chomp.split(",").map(&:to_i)
      if @board[flag_coordinates[0]][flag_coordinates[1]].flagged == false
        @board[flag_coordinates[0]][flag_coordinates[1]].flagged = true
      else
        @board[flag_coordinates[0]][flag_coordinates[1]].flagged = false
      end
      
    else  
      user_move = @board[user_ary[0]][user_ary[1]]    
      user_move.hidden = false
      if user_move.adjacent_mines == 0
      autoclear(user_ary[0], user_ary[1]) 
      end
    end
  end

  def render
    print "   "
    10.times do |column_number|
      print column_number.to_s
      print " "
    end
     print "\n"
    @board.each_with_index do |row, row_index|
      print " "
      print row_index
      print " "
#       binding.pry
      @board[row_index].each_with_index do |column, column_index|
#         binding.pry
        print @board[row_index][column_index].symbolize
        print " "
      end
      print row_index
      print"\n"
    end
    print "   "
    10.times do |iteration|
      print iteration.to_s
      print " "
    end
    print "\n"
  end


end
