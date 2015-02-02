require 'pry'
# require './board.rb'
# require './cell.rb'
#RSPEC didn't like the separate files, althought they are included and you may comment this out if this is how you wish to use it. In current form it is one file. 

class Minesweeper
  def initialize
    @game_board = Board.new
    @player = Player.new
    @player_wants_to_continue = true
    play
  end

  def play
    welcome
    while @player_wants_to_continue
      @game_board.select_coordinate(@player.get_user_input)

      @game_board.render
      if player_has_lost? || player_has_won?
        exit
      end
    end
  end

  def welcome
    puts "Welcome to minesweeper! For each move enter your coordinates array style, (i.e. type '5,5') if you want to quit type 'Q'! If you want to flag a mine, type 'F' first, then coordinates. Same method to unflag. Good luck!"
  end

  def player_has_lost?
    if @game_board.check_loss?
      puts "Sorry man, you lose!"
      return true
    end
  end

  def player_has_won?
    if @game_board.check_victory?
      puts "Congratulations! You win!"
      return true
    end
  end
end

class Player
  def get_user_input
    print ("Enter your move: ")
    player_choice = gets.chomp
    if player_choice.upcase == "Q"
      @player_wants_to_continue = false
      exit
    end
    if player_choice == "F"
      return player_choice
    else
      player_choice = player_choice.split(",").map(&:to_i)
      return player_choice
    end
  end
end



class Board
  attr_accessor :board, :size
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

class Cell
  attr_accessor :mine, :hidden, :flagged, :adjacent_mines
  def initialize(mine=false, hidden=true, flagged=false, adjacent_mines=0)
    @mine = mine
    @hidden = hidden
    @flagged = flagged
    @adjacent_mines = adjacent_mines
  end

  def symbolize
    if (@flagged)
      return "⚑"
    elsif(@hidden)
      return "■"
    elsif(@mine)
      return "✷"
    elsif(@adjacent_mines == 0)
      return "□"
    elsif(@adjacent_mines)
      return @adjacent_mines.to_s
    end
  end
end

# schwad = Minesweeper.new
# schwad