

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

  def render
    row_size = @gameboard.flatten.size**(1.0/2) #10
    row_count = 0
    initial_cell =0
    while row_count < @gameboard.size/row_size
      intial_cell = row_count * row_size
      #@gameboard.each_with_index do |cell, index|
      initial_cell.upto(row_size+initial_cell-1) do |column|
        print @gameboard[row_count*row_size+column].print_value
      end
      row_count += 1
      puts
    end
    true
  end
end



class Cell
	attr_reader :mine, :flag
	def initialize
		@mine = 0
		@flag = 0
	end

  def print_value
    0
  end
end