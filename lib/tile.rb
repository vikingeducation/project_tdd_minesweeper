class Tile

  def initialize(revealed: false, mine: false, flag: false)
    @revealed = revealed
    @mine = mine
    @flag = flag
  end

  def reveal!
    @revealed = true
  end

  def revealed?
    @revealed
  end

  def mine!
    @mine = true
  end

  def mine?
    @mine
  end

  def flag!
    @flag = !@flag
  end

  def flag?
    @flag
  end

end
