# All the player related activity in the game
class Player

  attr_accessor :use_flag

  def initialize(flags = 9)
    @flags = flags
  end

  def get_coordinates
    loop do
      coords = ask_for_coordinates
      coords = ask_for_flag

      if validate_coordinates_format(coords)
        if @board.add_to_board(coords, marker)
          break
        end
      end
    end
  end

  def ask_for_flag
    puts "Do you want to flag this cell as marked with a mine?"
    puts "Enter y for yes and n for no"
    input = gets.chomp.upcase

    if(input == "Y" || input == "N" )
      use_flag = true
    end
  end


  def ask_for_coordinates
    puts "Enter your coordinates in the form x,y:"
    gets.strip.split(",").map(&:to_i)
  end

  def validate_coordinates_format(coords)
    if coords.is_a?(Array) && coords.size == 2
      true
    else
      puts "Your coordinates are in the improper format!"
    end
  end

end