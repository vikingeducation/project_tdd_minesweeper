class Player

  def initialize
  end

# input 1,2 and then returns array
  def assign_input
    input = gets.chomp
    input.split(',').map(&:to_i)
  end


end
