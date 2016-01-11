class Tile

  def initialize
    @revealed = false
  end
    
  def revealed?
    @revealed
  end

  def reveal
    @revealed = true
  end

end
