class Player

  def initialize
  end

# input 1,2 and then returns array
  def assign_move
    move = gets.chomp
    assign_move unless valid_input?(move)
    move.split(',').map(&:to_i)
  end

  def assign_flag_location
    flag_loc = gets.chomp
    assign_flag_location unless valid_input?(flag_loc)
    flag_loc.split(',').map(&:to_i)
  end

  def valid_input?(input)
    /\d,\d/ === input
  end

end
