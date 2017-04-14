class Cell
  def initialize(row:, col:)
    @row_coordinate = row
    @column_coordinate = col
    @contents = '?'
  end

  def render
    @contents
  end

  def coordinates
    {x: @row_coordinate, y: @column_coordinate}
  end
end