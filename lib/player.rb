class Player

  def initialize
  end

  def click_selection
    puts "Which square would you like to clear(1) or place a flag(2)? ex)2,3,1 row 2 column 3 clear"
    coords = gets
    coords_array = coords.split(",").map! { |x| x.to_i }
    if inputs_valid?(coords_array)
      coords_array
    else
      raise "That is not a valid input"
      click_selection
    end
  end

  def inputs_valid?(coords)
    range = 0..9
    if range.include?(coords[0])  && range.include?(coords[1])
      if coords[2] == 1 || coords[2] == 2
        true
      else
        false
      end
    else
      false
    end
  end

end
