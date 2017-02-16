# Random generator to create Mine
class Mine

  attr_accessor :mine_arr

  def initialize
    @mine_arr = Array.new
  end

  # Generate random coordinates for placing a new mine
  def generate_coords
    coords = [0,0]
    coords[0] = rand(9)
    coords[1] = rand(9)
    coords
  end

  def mine_created?(ref)
    @mine_arr.any?{ |cell| cell == ref}
  end

  def create_mines(n)
    until @mine_arr.count == n do
      mine = generate_coords
      @mine_arr << mine unless @mine_arr.include?(mine)
    end
  end

  def is_adjacent?(cell, mine)
    x = (cell[0] - mine[0]).abs
    y = (cell[1] - mine[1]).abs

    if x < 2 && y < 2
      true
    else
      false
    end
  end

  def get_num_adj_mines(cell)
    adjacent_mines = 0
    @mine_arr.each do |mine|
      if is_adjacent?(cell, mine)
        adjacent_mines += 1
      end
    end
    adjacent_mines
  end
end
