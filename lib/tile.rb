class Tile

  def initialize
    @mine = false
    @flag = false
    @revealed = false
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
