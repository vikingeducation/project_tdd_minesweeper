require 'colorize'

class Board 
  attr_accessor :board
  
  #creates a board
  def initialize(board = nil)
    #populate the board, "x" for mine
    selection = [0,0,0,0,"x"]
    @height = 5
    @width = 5
    @board ||= Array.new(@height){Array.new(@width){selection.sample}}
    populate
  end

  #renders the board
  def render
    @width.times do
      print " _ "
    end

    @board.each_with_index do |row, r|
      print "|"
      row.each_with_index do |cell, col|
        print (cell == "x") ? "#{cell}|".red : "#{cell}|" 
      end
      print "\n"
    end
  end


  #populates the board
  def populate
    @board.each_with_index do |row, r|
      row.each_with_index do |cell, col|
        #find the number of mines surrounding the cell
        cell_coord = [r,col]
        @board[r][col] = num_mines(cell_coord) if !is_mine?(cell)  
      end
    end

  end

  def is_mine?(cell)
    cell == "x"
  end

  #top left of board is 0,0
  def num_mines(cell_coord)
    num = 0
    x = cell_coord[0]
    y = cell_coord[1]

    (-1..1).each do |m|
      (-1..1).each do |n|
        # check if it is a mine and validate if the cell is within the grid
        # so we aren't checking the -1 positions of arrays which would cause unexpected results
        if (x+m)>=0 && (x+m)<@width && (y+n)>=0 && (y+n)<@height
          num += 1 if is_mine?(@board[x+m][y+n]) 
        end
      end
    end

    num
  end

end