# Random generator to create Mine
class Mine

  attr_accessor :mines

  def initialize
    @mines = Array.new(9)
  end

  # Generate random coordinates for placing a new mine
  def generate_coords
    coords = [0,0]
    coords[0] = rand(0..9)
    coords[1] = rand(0..9)
    coords
  end


  def isAdjacent?(cell, mine)
    x = (cell[0] - mine[0]).abs
    y = (cell[1] - mine[1]).abs
    if x < 2 and y < 2
      true
    else
      false
    end
  end

  # Find coordinates for neighbouring cells that are definitely clear
  def clear_cells(cell)

    # work on the best way to store this

    first_clear[0] = cell[0] - 1
    first_clear[1] = cell[1]

    second_clear[0] = cell[0] + 1
    second_clear[1] = cell[1]

    third_clear[0] = cell[0]
    third_clear[1] = cell[1] - 1

    fourth_clear[0] = cell[0]
    fourth_clear[1] = cell[1] + 1

  end

  def get_adj_clear_cells
    if(getNumberAdjacentMines(cell) > 0)
      clear_cells
    end

    # Then we want to add these cell references to the board
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

  def mine_created?(ref)
    @mines.any?{ |cell| cell == ref}
  end
end
