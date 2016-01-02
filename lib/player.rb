class Player
  def initialize(board)
    @board = board
  end

  def display_instructions
    puts "Type 'f' for flag or 'o' for open followed by the location(e.g.'f33') then enter."
    puts "The first number is for the y coordinate."
    puts "Otherwise 'q' then enter to quit."
    puts ""
    print "Your Move: "
  end

  def turn
    display_instructions
    @board.place_players_move(get_response)
  end

  def get_response
    response = gets.chomp.downcase
    until response_is_valid?(response)
      display_instructions
      response = gets.chomp.downcase
      exit if response == 'q'
    end
    response
  end

  def response_is_valid?(response)
    return true if response == 'q'
    split_response = response.split('')
    return true if (split_response.size == 3) && (split_response[0] == 'o' || split_response[0] == 'f') && (('0'..'9').include? split_response[1]) && (('0'..'9').include? split_response[2])
    false
  end
end