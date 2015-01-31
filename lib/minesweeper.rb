class Cell
  attr_accessor :mine, :hidden, :flagged, :adjacent_mines
  def initialize(mine=false, hidden=true, flagged=false, adjacent_mines=nil)
    @mine = mine
    @hidden = hidden
    @flagged = flagged
    @adjacent_mines = adjacent_mines
  end
  
  def symbolize
    if (@flagged)
      return "F"
    elsif(@hidden)
      return "□"
    elsif(@mine)
      return "□"
    elsif(@adjacent_mines)
      return @adjacent_mines.to_s
    end
  end
end

class Board
  attr_accessor :board
  def initialize
    @board = Array.new(10) {Array.new(10){Cell.new}}
#     @board.each do |row|
#       @board[row].each do |column|
#         @board[row][column] = Cell.new
#       end
#     end
  end
  
  def generate_mines
    (1..100).to_a.sample(10)
  end
  
  def render
    print " "
    10.times do |iteration|
      print iteration.to_s
    end
     print "\n"
    @board.each do |row|
      print row.to_s
      @board[row].each do |column|
        print @board[row][column].symbolize
      end
      print"\n"
    end
  end
end

