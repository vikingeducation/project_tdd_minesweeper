# Stores the different states of the board
class Board

  attr_reader :board

  def initialize(board = nil)
    @board = board || Array.new(10){Array.new(10)}
  end

  def render
    puts
    board.each do |row|
      row.each do |cell|
        # Dont display the position of the mines when rendering
        if cell.nil? 
          print("-")
        elsif (cell == "X" && !full?)
          print("-")
         else
          print(cell.to_s)
        end
      end
      puts
    end
    puts
  end

  def within_valid_coordinates?(coords)
    if (0..9).include?(coords[0]) && (0..9).include?(coords[1])
        true
    else
        puts "The chosen coordinates are not in the range of the board"
    end
  end

  def coordinates_available?(coords)
      if @board[coords[0]][coords[1]].nil? || @board[coords[0]][coords[1]] == "X"
          true
      else
          puts "Position already used"
      end
  end


  def full?
      @board.all? do |row|
          row.none? {|x| x.nil?}
      end
  end

  def add_to_board(coords)
    if location_valid?(coords)
      @board[coords[0]][coords[1]] = "C"
        true
    else
        false
    end
  end

  def location_valid?(coords)
    if within_valid_coordinates?(coords)
        coordinates_available?(coords)
    end
  end




end
