class Board

  attr_reader :size, :mines, :grid

  def initialize (size: 10)
    @grid = Array.new(size) { Array.new(size) { Tile.new } }
    @size = size
    @mines = size - 1
  end

  def populate_mines(starting_coord)
    until placed_mine_count == @mines
      coord = random_coord
      next if coord == starting_coord
      tile = tile_at(coord)

      tile.mine!
    end
  end

  def tile_at(coord)
    row, col = coord
    @grid[row][col]
  end

  def random_coord
    row = (0...@size).to_a.sample
    col = (0...@size).to_a.sample
    [row, col]
  end

  def placed_mine_count
    @grid.flatten.count(&:mine?)
  end

  def load_grid(new_grid)
    @grid = new_grid.map do |row|
      row.map do |tile|
        case tile
        when "*"
          Tile.new(mine: true)
        when "_"
          Tile.new
        end
      end
    end
  end

end
