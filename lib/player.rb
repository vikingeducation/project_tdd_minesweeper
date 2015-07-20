class Player
  
  def get_coords
    loop do
    print "> "
    input = gets.chomp
    break if coords_valid?(input)
  end

  def coords_valid?(input)
    if input.is_a?(Integer)

    end
  end

end