class Square

  attr_accessor :has_bomb, :flagged, :revealed, :num_adjacent_bombs

  def initialize
    @flagged = false
    @revealed = false
  end

end