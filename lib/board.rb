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

  def reveal_coord(coord)
    row,col = coord
    tile = tile_at(coord)

    return false if tile.flag?
  
    tile.reveal!

  end

  def compare_grid(expected_grid)
    
    expected_grid.each_with_index do |row,row_index|
      row.each_with_index do |item,col_index|
        tile = tile_at([row_index,col_index])
     
        case item
        when "_"
          return false if tile.revealed?
        when "0"
          return false unless tile.revealed?  
        end  
      end  
    end 
    true
  end

end
