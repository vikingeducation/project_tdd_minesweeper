

class Board
attr_reader :mines, :gameboard, :size

  def initialize(size=10, mines=9)
    @mines = mines
    @size = size
    create_game_board(size)
    set_mines(mines)
  end


  def set_mines(mines)
    mines_to_set = mines
    while mines_to_set > 0
      cell = @gameboard.sample
      if cell.mine == 0
        cell.set_mine
        mines_to_set -= 1
      end
    end
  end

  def create_game_board(size)
    @gameboard = []
    for i in 0..(size**2 -1)
      @gameboard << Cell.new
    end
    #return gameboard
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
    initial_cell = 0
    while row_count < @gameboard.size/row_size
      intial_cell = row_count * row_size
      print ("Row #{row_count+1}: ").ljust(8)
      #@gameboard.each_with_index do |cell, index|
      initial_cell.upto(row_size+initial_cell-1) do |column|
        print @gameboard[row_count*row_size+column].print_value
      end
      row_count += 1
      puts
    end
    true
  end

  def change_state_of_square(square_to_change)
    @gameboard[square_to_change].state = 1 if @gameboard[square_to_change].state == 0
    lose?(square_to_change)
  end

  def lose?(cell)
    @gameboard[cell].mine == 1 ? true : false
  end
end

class Cell
	attr_reader :mine, :flag
  attr_accessor :state

  def initialize
		@mine = 0
		@flag = 0
    @state = 0
	end

  def print_value
    if @state == 0
      " \u2B1B"
    elsif @state == 1
      " \u25A2"
    end
  end

  def set_mine
    @mine = 1
  end
end