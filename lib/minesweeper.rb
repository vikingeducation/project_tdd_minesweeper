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
      return "⚑" #change to flag under dr au
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

class Board
  attr_accessor :board
  def initialize(size=10)
    @size = size
    @board = Array.new(@size) {Array.new(@size){Cell.new}}
    place_mines
  end
  
  def generate_mines
    (0..99).to_a.sample(10)
  end
  
  def place_mines
    mine_locations = generate_mines
    mine_locations.each do |x|
      tens = x / 10
      ones = x % 10
      @board[tens][ones].mine = true
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

myBoard = Board.new
myBoard.render



