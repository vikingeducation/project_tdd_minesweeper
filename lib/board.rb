require 'square'

class Board
  attr_reader :board

  def initialize(height, width, mines)
    @height = height    #rows
    @width = width      #cols
    @mines = mines      #number of mines in board
    @board = Array.new(@height) { Array.new(@width) }
    #directions to adjacent squares (including diagonals)
    @delta = [[1,0],[1,1],[0,1],[-1,1],[-1,0],[-1,-1],[0,-1],[1,-1]]
    fill_board_with_squares
    count_proximities
  end

  private_class_method :new

  #factory method
  def self.build_board(height, width, mines)
    raise ArgumentError, "Need integer inputs!" unless height.is_a?(Fixnum) && width.is_a?(Fixnum) && mines.is_a?(Fixnum)
    raise ArgumentError, "Inputs must be positive!" unless height > 0 && width > 0 && mines > 0
    raise ArgumentError, "Too many mines!" unless mines < height * width
    new(height, width, mines)
  end

  #semantic reader method for number of mines in board
  def mine_count
    return @mines
  end

  #if mine is at coord, return true, else run recursive clear_squares and return false (used for lose condition later)
  def process_move(row, col)
    if @board[row][col].has_mine?
      return 0
    elsif @board[row][col].cleared
      return 1
    else
      clear_squares(row, col)
      return 2
    end
  end

  #recursively set all square's @cleared instance to clear from current location to squares that have proximity
  #it's assumed the square at the location does not have a mine
  def clear_squares(row, col)
    #base cases
    return if row < 0 || row >= @height || col < 0 || col >= @width
    return if @board[row][col].has_mine?
    return if @board[row][col].cleared
    if @board[row][col].proximity >= 0
      @board[row][col].cleared = true
    end
    clear_squares(row + 1, col) #recurse north
    clear_squares(row - 1, col) #recurse south
    clear_squares(row, col + 1) #recurse east
    clear_squares(row, col - 1) #recurse west
  end

  private

  #fill board with empty squares and mine squares
  def fill_board_with_squares
    #fill board with mines at random locations
    @mines.times do |mine_iterator|
      random_row = (0...@height).to_a.sample
      random_col = (0...@width).to_a.sample
      redo unless @board[random_row][random_col].nil?
      @board[random_row][random_col] = Square.build_mine
    end
    #then fill the rest with empty squares
    (0...@height).each do |row_index|
      (0...@width).each do |col_index|
        @board[row_index][col_index] = Square.build_empty if @board[row_index][col_index].nil?
      end
    end
  end

  #sets the each square's @proximity to # of mines in it's adjacent squares (including diagonals)
  def count_proximities
    #iterate through every square in board
    @board.each_with_index do |row, r_index|
      row.each_with_index do |col, c_index|
        #skip current iteration if current Square element has a mine
        #puts col.inspect
        next if col.has_mine?
        mine_count = 0
        neighbors = []
        #for each square, generate valid neighbor square coordinates
        @delta.each do |step|
          new_pos = [r_index + step[0], c_index + step[1]]
          neighbors << new_pos if valid_coord?(new_pos)
        end
        #check each valid neighbor coordinate for existence of mine
        neighbors.each do |loc|
          mine_count += 1 if @board[loc[0]][loc[1]].has_mine?
        end
        #save the mine count to @proximity instance var for this square
        col.proximity = mine_count
      end
    end
  end

  #for a [x, y] array input, return true if valid board coordinate
  def valid_coord?(coord)
    (0...@height).to_a.include?(coord[0]) && (0...@width).to_a.include?(coord[1])
  end
end
