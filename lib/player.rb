class Player

  attr_reader :difficulty

  def initialize
  end

  def level
    print "Select level (B)beginner, (I)intermediate, (A)advanced:"
    selected_level = gets.chomp.upcase
    @difficulty = selected_level[0]
  end

  def select_move(gameboard)
    print "Enter move (row,col): "
    move = gets.chomp.split ","
    move.map {|col| col.to_i}
    validate(move, gameboard)
  end

  def validate?(move, gameboard)
    row_size = gameboard.flatten.size**(1.0/2)
    ((1..row_size+1).include? move[0]) && ((1..row_size+1).include? move[1]) ? true : false
  end
end


    # if @difficulty == "B"
    #    size = 5
    # elsif @difficulty == "I"
    #   size = 10
    # else @difficulty == "A"
    #   size = 20
    # end
    # return size