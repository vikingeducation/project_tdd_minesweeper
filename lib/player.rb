class Player

  attr_reader :row, :column, :marker, :response

  def initialize 
    @row = nil
    @column = nil
    @marker = nil
    @response = nil 
  end

  def row_move
    puts "Enter row 1-10:"
    @row = gets.chomp.to_i
  end

  def col_move
    puts "Enter column 1-10:"
    @column = gets.chomp.to_i
  end

  def valid_coordinates?(row, col)
    row.between?(1, 10) && col.between?(1, 10)
  end

  def set_coordinates(row, col)
    @row = row - 1
    @column = col - 1
  end

  def open_or_flag
    puts "Enter 'o' to open or 'f' to flag a square"
    @response = gets.chomp 
  end

  def valid_response?(user_input)
    user_input == "o" || user_input == "f"
  end

  def set_marker(user_input)
    user_input == "f" ? @marker = :F : @marker = :O
  end
end







