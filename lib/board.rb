require 'colorize'
require 'pry-byebug'

# uses a board for data and a play_board for the user to interac with
# play_board is responsible for flags, clicking, interaction
# board holds all the cell data (mines, numbers etc.)
class Board 
  attr_accessor :board, :play_board, :loss#, :play_coord
  
  #creates a board
  def initialize(h=5, w=5, board = nil)
    #populate the board, "x" for mine
    selection = [0,0,0,0,"x"]
    @height = h
    @width = w
    @loss = false
    @board ||= Array.new(@height){Array.new(@width){selection.sample}}
    @play_board = Array.new(@height){Array.new(@width)}
    populate
  end

  #renders the board
  def render
    # @board.each_with_index do |row, r|
    #   print "|"
    #   row.each_with_index do |cell, col|
    #     print (cell == "x") ? "#{cell}|".red : "#{cell}|" 
    #   end
    #   print "\n"
    # end

    @play_board.each_with_index do |row, r|
      print "|"
      row.each_with_index do |cell, col|
        print cell.nil? ? " |" : "#{cell}|" #(cell == "x") ? "#{cell}|".red : "#{cell}|" 
      end
      print "\n"
    end
  end

  def win?
    win = true

    @board.each_with_index do |row, r|
      row.each_with_index do |cell, col|
        if @play_board[r][col].nil?
          win = false 
          break
        end

        if is_mine?(cell)
          if !is_flag?(@play_board[r][col])
            win = false
            break
          end
        end
      end
    end

    win
  end

  def lose?
    @loss
  end

  def flag_cell(coord)
    x = coord[0]
    y = coord[1]
    @play_board[x][y] = "F"
  end

  def is_flag?(cell)
    cell == "F"
  end

  def click_cell(coord)
    x = coord[0]
    y = coord[1]

    if is_mine?(@board[x][y])
      blow_up
    elsif @board[x][y] != 0
      @play_board[x][y] = @board[x][y] #show particular cell
    elsif @board[x][y] == 0
      show_cluster(coord) #show cluster
    end
  end

  # checks if the cell is already shown on the playboard
  def cell_shown?(coord)
    x = coord[0]
    y = coord[1]

    play_coord = @play_board[x][y]
    data_coord = @board[x][y]

    play_coord == data_coord
  end

  def show_cluster(coord)
    x = coord[0]
    y = coord[1]

    (-1..1).each do |m|
      (-1..1).each do |n|
        # if coord is within the grid
        if (x+m)>=0 && (x+m)<@width && (y+n)>=0 && (y+n)<@height
          # if square is already revealed, skip
          if @play_board[x+m][y+n] == @board[x+m][y+n]
            next
          end

          # show the square unless it is flagged
          @play_board[x+m][y+n] = @board[x+m][y+n] unless is_flag?(@play_board[x+m][y+n])

          show_cluster([x+m,y+n]) if @board[x+m][y+n] == 0 
        end
      end
    end

    #set up the coordinate
    #Loop through each surrounding cell
      #If cell is nonzero
        #
      #If cell is zero
        #Loop through each surrounding cell (recurse)
      #end
    #end


  end

  #game is lost
  #shows everything
  def blow_up
    @play_board = @board
    @loss = true
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