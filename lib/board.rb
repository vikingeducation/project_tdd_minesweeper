class Board

  attr_reader :board, :flags

  def initialize
    @board = Array.new(10){Array.new(10)}
    @flags = 15
  end

  def render
    puts "# You have #{flags} flags remaining"
    puts
    @board.each_with_index do |row, row_index|
      row.each_with_index do |cell, cell_index|
        cell.nil? ? print("-".center(4)) : print(cell.to_s.center(4))
      end
      puts
    end
  end

  def place_mines
    mine_array = []
    9.times do
      mine_array << [rand(10), rand(10)]
    end
    mine_array
  end

end