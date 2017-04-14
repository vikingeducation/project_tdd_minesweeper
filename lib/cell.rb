class Cell
  attr_reader :contents

  def initialize(row:, col:)
    @row_coordinate = row
    @column_coordinate = col
    @contents = '?'
  end

  def coordinates
    { x: @row_coordinate, y: @column_coordinate }
  end
end