class MinesweeperCLI
  def get_coordinates
    puts "Enter coordinates to reveal '4,5' or 'f4,5' to flag"
    coord = gets.chomp.split(",")
    coord.map { |coordinate| coordinate.to_i}
  end

  def render(board)
    puts board.render_board
  end
end
