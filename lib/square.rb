class Square

  attr_accessor :has_bomb, :flagged, :revealed, :num_adjacent_bombs, :row, :col

  def initialize(options={})
    @flagged = false
    @revealed = false
    @row = options[:row]
    @col = options[:col]
  end

end