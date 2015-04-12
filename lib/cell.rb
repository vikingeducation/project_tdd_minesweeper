class Cell

attr_reader :value, :is_bomb

  def initialize( value = 0, is_bomb = false )
    @value = value
    @is_bomb = is_bomb
  end

end