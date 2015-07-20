class Player

  def get_move
    move = []
    loop do
      move << get_coords
      break if move << get_action 
    end
    move
  end
  
  def get_coords
    coords = ""
    loop do
      print "input row and column, example '1,2' > "
      input = gets.chomp
      break if coords = coords_valid?(input)
    end
    coords
  end


  def coords_valid?(input)
    input = input.split(",")
    input.map! { |i| i.to_i }
    if input.length == 2
      input
    else
      false
    end
  end


  def get_action
    move = ""
    loop do
      print "'f'lag or 'r'eveal the cell? > "
      input = gets.chomp
      break if move = action_valid?(input)
    end
    move
  end


  def action_valid?(input)
    if input == 'f'
      :flag
    elsif input == 'r' 
      :reveal
    else
      false
    end
  end

end