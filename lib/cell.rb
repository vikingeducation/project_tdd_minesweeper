class Cell

  attr_reader :cleared, :flagged, :exploded, :adjacent_mines
  attr_accessor :mine

  def initialize
    @mine = false
    @cleared = false
    @flagged = false
    @exploded = false
    @adjacent_mines = 0
  end

  def mine?
    mine
  end

  def cleared?
    cleared
  end

  def flagged?
    flagged
  end

  def exploded?
    exploded
  end

  def place_mine
    @mine = true
  end

  def count_adjacent_mine
    @adjacent_mines += 1
  end

  def clear
    @cleared = true unless flagged?
    @exploded = true if hit_mine?
  end

  def flag
    @flagged = true unless cleared?
  end

  def to_s
    if cleared?
      return "✷" if exploded?
      if adjacent_mines == 0
        " "
      else
        adjacent_mines.to_s
      end
    else
      if flagged?
        "⚑"
      else
        "█"
      end
    end
  end

  private

  def hit_mine?
    mine? && cleared?
  end
end