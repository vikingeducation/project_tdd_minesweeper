class Tile
  attr_accessor :unsafe_neighbors

  def initialize(mine: false, flag: false, revealed: false)
    @mine = mine
    @flag = flag
    @revealed = revealed
    @unsafe_neighbors = 0
  end

  def safe?
    !@mine
  end

  def revealed?
    @revealed
  end

  def flagged?
    @flag
  end

  def mine!
    @mine = true
  end

  def flag!
    @flag = true
  end

  def reveal!
    @revealed = true
  end


end
