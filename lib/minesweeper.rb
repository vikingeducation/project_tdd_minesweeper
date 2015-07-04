require 'board'

class Minesweeper
  attr_accessor :board
  
  def initialize
    @board=Board.new

  end

  def game

  end

end



=begin
  
Set up game [Minesweeper]
Set up blank 10x10 board [Board]
Random put 9 mines [Board]
Keep flags, "cleared squares" and bordermines_number [Board]
Square should has states: cleared (show mine or not), flag
Should show remaining flags [Board]


Should change state of a board square [Player]

Set flag at coordinates [Player]
  
=end