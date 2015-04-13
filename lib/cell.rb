class Cell
  attr_accessor :value, :is_a_mine, :adjacent_mines, :flagged

  def initialize(value = 0, is_a_mine = false, is_visible = false, flagged = false)
    @value = value
    @is_a_mine = is_a_mine
    @is_visible = is_visible
    @adjacent_mines = 0
    @flagged = flagged
  end

  def icon
    if @is_a_mine && @is_visible
      return '💣'
    elsif @flagged
      return '⚑'
    elsif !@is_visible
      return '❏'
    elsif @value == 0
      return '✓'
    end
    @value
  end

  def toggle_flag
    @flagged = !@flagged
  end

  def mine_henshin
    @is_a_mine = !@is_a_mine
  end

  def toggle_visibility
    @is_visible = !@is_visible
  end

  def is_visible?
    @is_visible
  end

  def set_value( number )
    @value = number
  end

  def is_a_mine?
    is_a_mine
  end

  def is_empty?
    true if @value == 0
  end

end
