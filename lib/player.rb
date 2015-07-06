class Player

  attr_reader :difficulty

  def initialize
  end

  def level
    print "Select level (B)beginner, (I)intermediate, (A)advanced:"
    selected_level = gets.chomp.upcase
    @difficulty = selected_level[0]
  end

  def select_move

  end


end