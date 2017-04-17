class Cell
  attr_reader :contents

  def initialize(row:, col:)
    @row_coordinate = row
    @column_coordinate = col
    @contents = '?'
    @cleared = false
  end

  def cleared?
    @cleared
  end

  def clear
    @cleared = true
    @contents = ' '
  end

  def coordinates
    { x: @row_coordinate, y: @column_coordinate }
  end
end