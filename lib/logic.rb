module Logic
  
  def cell(coords)
    return nil unless coords.all? { |i| @range.include?(i) }
    @grid[coords[0]][coords[1]]
  end


  def count_mined_neighbors(coords)
    neighbors = get_neighbors(coords)
    count = neighbors.count { |neighbor| cell(neighbor).mined? }
    cell(coords).mined_neighbors = count 
  end


  def get_neighbors(coords)
    row = coords[0]
    col = coords[1]
    neighbors = []

    possible_neighbors = [
    [row-1, col-1], [row-1, col], [row-1, col+1],
    [row, col-1],                 [row, col+1],
    [row+1, col-1], [row+1, col], [row+1, col+1]]

    possible_neighbors.each do |neighbor|
      unless cell(neighbor) == nil
        neighbors << neighbor
      end
    end

    neighbors
  end


  def auto_reveal_search(coords)
    queue = [coords]
    until queue.empty?

      test_cell = queue.pop
      neighbors = get_neighbors( test_cell )

      queue += queue_cells_for_search(neighbors)

      auto_reveal_cells(neighbors)

    end
  end


  def auto_reveal_cells(cells)
    cells.each do |coords|
      cell(coords).reveal! if auto_reveal?(coords)
    end
  end


  def queue_cells_for_search(cells)
    queue = []
    cells.each do |coords|
      queue << coords if add_to_queue?(coords)
    end
    queue
  end
  

  def auto_reveal?(coords) 
    cell(coords).covered? == true &&
    cell(coords).mined? == false &&
    cell(coords).flagged? == false
  end


  def add_to_queue?(coords)
    auto_reveal?(coords) && cell(coords).mined_neighbors == 0
  end

end