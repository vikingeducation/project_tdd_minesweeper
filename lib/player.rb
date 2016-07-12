class Player
  
  def initialize
    @view = View.new
  end

  def assign_input
    
    gets.chomp
  end
end