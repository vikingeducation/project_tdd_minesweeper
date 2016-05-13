class Board
  attr_accessor :height, :width, :tiles, :mines

  def initialize(height=10, width=10, mines=9)
    @height, @width, @mines, @tiles = height, width, mines, []

    create_board
    randomly_place_mines
    adjacent_mines
  end

  def create_board
    (0...@width).each do |x|
      (0...@height).each do |y|
        @tiles[x] = [] unless tiles[x]
        @tiles[x][y] = Tile.new(x,y)
      end
    end
  end

  def randomly_place_mines
    placed_mines = 0

    while placed_mines < @mines
      x = rand(@width)
      y = rand(@height)
      tile = @tiles[x][y]

      unless tile.has_mine
        tile.has_mine = true
        placed_mines += 1
      end
    end
  end

  def adjacent_mines
    @tiles.flatten.each do |tile|
      neighbors = find_neighbors(tile)
      tile.neighboring_mines = count_mines_from(neighbors)
    end
  end

  def find_neighbors(tile)
    @tiles.flatten.select do |t|
      (t.x <= (tile.x + 1) && t.x >= (tile.x - 1)) &&
      (t.y <= (tile.y + 1) && t.y >= (tile.y - 1)) &&
      tile != t
    end
  end

  def count_mines_from(neighbors)
    neighbors.select do |num|
      num.has_mine == true
    end.size
  end
end
