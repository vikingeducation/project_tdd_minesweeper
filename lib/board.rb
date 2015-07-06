require 'cell'

class Board
attr_reader :gameboard, :mines

  def initialize(size=10, mines = 9)
    @mines = mines
    @gameboard = [] 	#(0..(size**2 -1)).to_a
    for i in 0..(size**2 -1)
     	@gameboard << Cell.new
     end
  end

  def remaining_flags
  	flag_count = 0
  	@gameboard.each do |cell|
  		flag_count += 1 if cell.flag == 1
  	end
  	@mines - flag_count
  end
end



class Cell
	attr_reader :mine, :flag
	def initialize
		@mine = 0
		@flag = 0
	end
end