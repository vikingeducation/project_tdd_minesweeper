# All the player related activity in the game
class Player

  attr_accessor :use_flag, :flags

  def initialize(flags = 9)
    @flags = flags
    use_flag = false
  end

  def get_coordinates

    coords = ""
    loop do
      coords = ask_for_coordinates

      if validate_coordinates_format(coords)
        break
      end
    end
    coords
  end

  def ask_for_flag
    puts "Do you want to flag this cell as marked with a mine?"
    puts "Enter y for yes and n for no"
    input = gets.strip.upcase

  
    if input == "Y"
      if (flags > 0)
        use_flag = true
      else
        puts "No flags remaining"
        use_flag = false
      end
    elsif input == "N"
      use_flag = false
    else
      ask_for_flag 
    end
    use_flag
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