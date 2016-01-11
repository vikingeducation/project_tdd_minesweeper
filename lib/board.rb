
class Board

  attr_reader :size, :mines, :grid

  def initialize (size: 10)
    @grid = Array.new(size) { Array.new(size) { Tile.new } }
    @size = size
    @mines = size - 1
  end  

end