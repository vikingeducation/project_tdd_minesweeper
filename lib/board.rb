require_relative 'tile'

class Board
  attr_reader :grid, :mines, :flags

  def initialize(size: 10, mines: 9)
    @size = size
    @grid = []
    size.times do
      @grid << []
    end
    @mines = mines
    @flags = mines
  end

  def populate_board(given_coord)
    unplaced_mines = @mines
    until unplaced_mines == 0
      coord = random_coord
      next if coord == given_coord
      place_mine(coord)
      unplaced_mines -= 1
    end
  end

  def move(coord)
    tile_at(coord).reveal!

    return true unless tile_at(coord).safe?
    false
  end

  def place_mine(coord)
    tile = tile_at(coord)
    tile.mine!
  end

  def render
  end

  def tile_at(coord)
    x, y = coord
    @grid[x][y]
  end

  private

  def random_coord
    x = (0...@size).to_a.sample
    y = (0...@size).to_a.sample
    [x,y]
  end
end
