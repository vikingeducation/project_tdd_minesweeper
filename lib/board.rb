require 'square'

class Board

  def initialize(height, width, mines)
    @height = height    #rows
    @width = width      #cols
    @mines = mines      #number of mines in board
    @board = Array.new(@height) { Array.new(@width) }
  end

  private_class_method :new

  #factory method
  def self.build_board(height, width, mines)
    raise ArgumentError, "Need integer inputs!" unless height.is_a?(Fixnum) && width.is_a?(Fixnum) && mines.is_a?(Fixnum)
    raise ArgumentError, "Inputs must be positive!" unless height > 0 && width > 0 && mines > 0
    raise ArgumentError, "Too many mines!" unless mines < height * width
    new(height, width, mines)
  end

  #count_proximities
    #sets the each square's @proximity to the appropriate number of mines in it's adjacent squares (including diagonals)

  #process_move(row_location, col_location)
    #if there is a mine at location, return true
    #else
      #run clear_squares

  #clear_squares(row_location, col_location)
    #recursively set all square's @cleared instance to clear from current location to appropriate boundaries

end
