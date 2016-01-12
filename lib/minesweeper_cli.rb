class MinesweeperCLI
  def get_coordinates
    puts "Enter coordinates"
    coord = gets.chomp.split(",")
    coord.map { |coordinate| coordinate.to_i}
  end

  def render(board)
    puts board.render_board
  end
end
