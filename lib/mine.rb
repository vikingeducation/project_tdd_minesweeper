# Random generator to create Mine
class Mine

  attr_accessor :mines

  def initialize()
    @mines = Array.new
  end

  # Generate random coordinates for placing a new mine
  def generate_coords
    coords = [0,0]
    coords[0] = rand(0..9)
    coords[1] = rand(0..9)
    coords
  end

  def mine_created?(ref)
    @mines.any?{ |cell| cell == ref}
  end

  def create_mines(n)
    # loop do
    #   mine = generate_coords
    #   # if !(mine_created?(mine))
    #     @mines << mine
    #     n -= 1
    #   end
    #   break if n == 1
    # end
    until @mines.count == 9 do
      mine = generate_coords

      @mines << mine unless @mines.include?(mine)
    end

  end

  def isAdjacent?(cell, mine)
    x = (cell[0] - mine[0]).abs
    y = (cell[1] - mine[1]).abs

    if x < 2 && y < 2
      true
    else
      false
    end
  end


  # Find coordinates for neighbouring cells that are definitely clear
  def update_neighbour_refs(cell)

    if(getNumberAdjacentMines(cell) > 0)
      all_directions = [
          [-1, 1],  [0, 1],  [1, 1],
          [-1, 0],           [1, 0],
          [-1, -1], [0, -1], [1, -1]
        ]

      all_directions.each do |adj_cell|
        neighbour = [adj_cell[0] + pos[0], adj_cell[1] + pos[1]]
        next unless (0..8).include?(neighbour[0]) && (0..8).include?(neighbour[1])


        # add to board -> neighbour, "C"


        # unless @minefield.all_tiles[neighbor[0]][neighbor[1]].revealed
        #   reveal(neighbor)
        # end
      end
    end
  end


  def getNumberAdjacentMines(cell)
    adjacentMines = 0
    @mines.each do |mine|
      if isAdjacent?(cell, mine)
        adjacentMines += 1
      end
    end
    adjacentMines
  end
end
