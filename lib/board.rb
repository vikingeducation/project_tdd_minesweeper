class Board

  NEIGHBOR_COORDS = [
    [0,1],
    [1,1],
    [1,0],
    [1,-1],
    [0,-1],
    [-1,-1],
    [-1,0],
    [-1,1]
  ]

  attr_reader :size, :mines, :grid

  def initialize (size: 10)
    @grid = Array.new(size) { Array.new(size) { Tile.new } }
    @size = size
    @mines = size - 1
  end

  def populate_mines(starting_coord)
    skip_coords = neighbor_coords(starting_coord)
    skip_coords << starting_coord
    until placed_mine_count == @mines
      coord = random_coord
      next if skip_coords.include?(coord)
      tile = tile_at(coord)

      tile.mine!
    end
    set_danger_levels
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
    set_danger_levels
  end

  def reveal_coord(coord)
    row,col = coord
    tile = tile_at(coord)

    return false if tile.flag?
    return false if tile.revealed?

    tile.reveal!

    if tile.completely_safe?
      neighbor_coords(coord).each do |neighbor_coord|
        reveal_coord(neighbor_coord)
      end
    end

    if tile.mine?
      @grid.flatten.select(&:mine?).each(&:reveal!)
    end
  end

  def danger_coords
    coords = []
    @size.each do |row|
      @size.each do |col|
        coords << [row, col] if tile_at([row,col]).danger_level > 0
      end
    end
    coords
  end

  def flag_coord(coord)
    row,col = coord
    tile = tile_at(coord)

    return false if tile.revealed?

    tile.flag!
  end

  def set_danger_levels
    @size.times do |row|
      @size.times do |col|
        set_danger_level([row, col])
      end
    end
  end

  def set_danger_level(coord)
    tile = tile_at(coord)
    level = neighbor_tiles(coord).count(&:mine?)
    tile.danger_level = level
  end

  def neighbor_coords(coord)
    row, col = coord
    NEIGHBOR_COORDS.map do |rowdiff, coldiff|
      neighbor_col = coldiff + col
      neighbor_row = rowdiff + row
      coord = [neighbor_row, neighbor_col]
      if valid_coord(coord)
        coord
      else
        nil
      end
    end.compact
  end

  def neighbor_tiles(coord)
    neighbor_coords(coord).map do |coord|
      tile_at(coord)
    end
  end

  def valid_coord(coord)
    coord.each do |direction|
      return false if direction < 0 || direction >= @size
    end
    true
  end


  def to_s
    @grid.map do |row|
      row.map do |tile|
        tile.to_s
      end.join(" ")
    end.join("\n")
  end

  def compare_grid(expected_grid)
    expected_grid.each_with_index do |row,row_index|
      row.each_with_index do |item,col_index|
        tile = tile_at([row_index,col_index])

        case item
        when "_"
          return false if tile.revealed?
        when "!"
          return false unless tile.flagged?
        else
          return false unless item.to_i == tile.danger_level
        end
      end
    end
    true
  end

end
