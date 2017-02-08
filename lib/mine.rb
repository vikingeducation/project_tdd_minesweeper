# Random generator to create Mine
class Mine

  attr_accessor :mines

  def initialize

  end

  # Generate random coordinates for placing a new mine
  def generate_coords
    coords = [0,0]
    coords[0] = rand(0..9)
    coords[y] = rand(0..9)
    coords
  end


  def isAdjacent(cell, mine)
    x = (cell[0] - mine[0]).abs
    y = (square[1] - mine[1]).abs
    if x < 2 and y < 2
      true
    else
      false
    end
  end

  # call this method if there is no mine adjacent
  def clear_cells(cell)
    first_clear[0] = cell[0] - 1
    first_clear[1] = cell[1]

    second_clear[0] = cell[0] + 1
    second_clear[1] = cell[1]

    third_clear[0] = cell[0]
    third_clear[1] = cell[1] - 1

    fourth_clear[0] = cell[0]
    fourth_clear[1] = cell[1] + 1

  end

  def getNumberAdjacentMines(cell)
    adjacentMines = 0
    @mines.each do |mine|
      if isAdjacent(cell, mine)
        adjacentMines += 1
      end
    end
    adjacentMines
  end
end
