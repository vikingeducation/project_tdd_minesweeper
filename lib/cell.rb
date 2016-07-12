class Cell
  attr_reader :display_state, 

  def initialize(coords, board)
    @coord ||= coords
    @x = @coords[1]
    @y = @coords[0]
    @board ||= board
    @revealed = false
    @flag = false
    determine_state
  end

  def render_token
    if @revealed
      @display_state
    elsif @flag
      flag_token
    else
      default_token
    end
  end

  def flag
    @flag = true unless @revealed
  end

  def unflag
    @flag = false
  end

  def reveal
    @revealed = true
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
