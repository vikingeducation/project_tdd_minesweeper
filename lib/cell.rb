class Cell
  attr_reader :contents

  def initialize(row:, col:)
    @row_coordinate = row
    @column_coordinate = col
    @contents = '?'
    @cleared = false
    @mined = false
  end

  def cleared?
    @cleared
  end

  def clear
    @cleared = true
    @contents = ' '
  end

  def set_mine
    @mined = true
  end

  def coordinates
    { x: @row_coordinate, y: @column_coordinate }
  end

  def mined?
    @mined
  end
end