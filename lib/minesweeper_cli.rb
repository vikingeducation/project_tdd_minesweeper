class MinesweeperCLI
  def get_coordinates
    puts "Enter coordinates"
    coord = gets.chomp.split(",")
  end

  def render(board)
    puts "This is the board"
  end
end
