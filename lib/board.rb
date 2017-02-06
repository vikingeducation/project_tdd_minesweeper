# Stores the different states of the board
class Board

  attr_reader :board

  def initialize(board_arr = nil)
    @board = Array.new(10){Array.new(10)}
  end

  def render
    puts
    board.each do |row|
      row.each do |cell|
        cell.nil? ? print("-") : print(cell.to_s)
      end
      puts
    end
    puts
  end

  def within_valid_coordinates?(coords)
    if (0..9).include?(coords[0]) && (0..9).include?(coords[1])
        true
    else
        # display an error message
        puts "Piece coordinates are out of bounds"
    end
  end

  def coordinates_available?(coords)
      if @board[coords[0]][coords[1]].nil?
          true
      else
          # display error message
          puts "There is already a piece there!"
      end
  end


  def full?
      @board.all? do |row|
          row.none? {|x| x.nil?}
      end
  end

end
