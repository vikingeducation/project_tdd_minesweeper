class Cell
  attr_reader :display_state

  def initialize(coords, board)
    @coord ||= coords
    @x = @coords[1]
    @y = @coords[0]
    @board ||= board
    determine_state
  end

  def determine_state
    @neighbors = get_neighbors
    @num_of_mines = @neighbors.select { |cell| cell.is_a?(Mine) }.length
    @display_state = @num_of_mines == 0 ? :empty : @num_of_mines
  end

  def get_neighbors
    neighbors_relations = [
      [ @x,    (@y+1)],
      [(@x+1), (@y+1)],
      [(@x+1),  @y],
      [(@x+1), (@y-1)],
      [ @x,    (@y-1)],
      [(@x-1), (@y-1)],
      [(@x-1),  @y],
      [(@x-1), (@y+1)]
    ]
      @board.get_cell_at_xy(neighbors_relations)
  end



end