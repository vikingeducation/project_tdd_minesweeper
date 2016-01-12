require_relative 'tile'

class Board
  attr_reader :grid, :mines, :flags

  def initialize(size: 10, mines: 9, grid: nil)
    @size = size
    @grid = grid || Array.new(size) { Array.new(size) }
    populate_tiles unless grid
    @mines = mines
    @flags = mines
  end

  def populate_tiles
    @grid.each_with_index do |row, y|
      row.each_index do |x|
        @grid[y][x] = Tile.new
      end
    end
  end

  def populate_board(given_coord)
    illegal_coords = [given_coord]
    unplaced_mines = @mines
    until unplaced_mines == 0
      coord = random_coord
      next if illegal_coords.include?(coord)
      place_mine(coord)
      illegal_coords << coord
      unplaced_mines -= 1
    end
  end

  def move(coord)
    tile_at(coord).reveal!
    if tile_at(coord).unsafe_neighbors == 0
      reveal_neighbors(coord)
    end
    return true unless tile_at(coord).safe?
    false
  end

  def place_mine(coord)
    tile = tile_at(coord)
    tile.mine!
  end

  def check_neighbors
    @grid.each_with_index do |row, y|
      row.each_with_index do |tile, x|
        check_neighbor(y,x) if tile.safe?
      end
    end
  end

  def check_neighbor(y,x)
    neighbors = [ [y-1,x-1],[y-1,x],  [y-1,x+1],
                  [y,x-1  ],          [y,x+1  ],
                  [y+1,x-1],[y+1,x  ],[y+1,x+1] ]
    bad_neighbors = 0
    neighbors.each do |coord|
      if tile_exists?(coord)
        neighbor = @grid[coord[0]][coord[1]]
        bad_neighbors += 1 unless neighbor.safe?
      end
    end
    @grid[y][x].unsafe_neighbors = bad_neighbors
  end

  def reveal_neighbors(coord)
    #coords is player input
    x = coord[1]
    y = coord[0]

    neighbors = [ [y-1,x-1],  [y-1,x],    [y-1,x+1],
                  [y,x-1  ],              [y,x+1  ],
                  [y+1,x-1],  [y+1,x  ],  [y+1,x+1] ]

    neighbors.each do |neighbor_coord|
      if tile_exists?(neighbor_coord)
        tile = tile_at(neighbor_coord)
        if tile.safe? && !tile.revealed?
          tile.reveal!
          if tile.unsafe_neighbors == 0
            reveal_neighbors(neighbor_coord)
          end
        end
      end
    end
  end

  def tile_exists?(tile_coord)
    y = tile_coord[0]
    x = tile_coord[1]
    y >= 0 && y < @size && x >= 0 && x < @size
  end

  def render_board
    string = ''
    @grid.each do |row|
      row.each do |tile|
        string << tile.render_tile
        string << " "
      end
      string << "\n"
    end
    string
  end

  private

  def tile_at(coord)
    @grid[coord[0]][coord[1]]
  end

  def random_coord
    x = (0...@size).to_a.sample
    y = (0...@size).to_a.sample
    [x,y]
  end
end
