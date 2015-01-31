class Cell

  attr_reader :mine, :cleared, :flagged, :adjacent_mines

  def initialize
    @mine = false
    @cleared = false
    @flagged = false
    @adjacent_mines = 0
  end

  # This ends the game!
  def exploded?
    mine && cleared
  end

  def place_mine
    @mine = true
  end

  def count_adjacent_mine
    @adjacent_mines += 1
  end

  def clear
    @cleared = true unless flagged
  end

  def flag
    @flagged = true unless cleared
  end

  def unflag
    @flagged = false
  end

  def to_s
    if cleared
      cleared_string_states
    else
      uncleared_string_states
    end
  end

  private

  def cleared_string_states
    return "✷" if exploded?
    if adjacent_mines == 0
      " "
    else
      adjacent_mines.to_s
    end
  end

  def uncleared_string_states
    if flagged
      "⚑"
    else
      "█"
    end
  end
end