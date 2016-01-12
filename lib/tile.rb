class Tile

  attr_accessor :danger_level

  def initialize(revealed: false, mine: false, flag: false)
    @danger_level = 0
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

  def completely_safe?
    if danger_level == 0 && !mine?
      true
    else
      false
    end
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

  def to_s
    if revealed?
      if mine?
        "*"
      else
        danger_level.to_s
      end
    else
      if flag?
        "!"
      else
        "_"
      end
    end
  end

end
