class Player
  def get_input
    loop do
      puts "Make input"
      input = gets.chomp.split(",")
      return input if input[0] == "Q"
      if valid_input? input
        input[0] = input[0].to_i
        input[1] = input[1].to_i
        return input
      end
    end
  end

  def valid_input? input
    if input.size == 3
      return true if input[0].to_i.is_a?(Fixnum) && 
                     input[1].to_i.is_a?(Fixnum) && 
                     ["C","F"].include?(input[2].upcase)
    end
  end

end