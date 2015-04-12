class Cell

attr_reader :value, :is_a_mine

  def initialize( value = 0, is_a_mine = false, is_visible = false )
    @value = value
    @is_a_mine = is_a_mine
    @is_visible = is_visible
  end

  def mine_henshin
    @is_a_mine = !@is_a_mine
  end

  def toggle_visibility
    @is_visible = !@is_visible
  end

  def check_visibility
    @is_visible
  end

  def set_value( number )
    @value = number
  end

end