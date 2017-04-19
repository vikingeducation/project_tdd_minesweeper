class Cell
  attr_reader :contents
  attr_accessor :neighbors

  def initialize(row:, col:)
    @row_coordinate = row
    @column_coordinate = col
    @contents = '?'
    @cleared = false
    @mined = false
    @neighbors = []
  end

  def clear
    raise Errors::CellWasMinedError, 'You found a mine!' if mined?

    @cleared = true
    @contents = mine_count > 0 ? mine_count.to_s : ' '
  end

  def cleared?
    @cleared
  end

  def coordinates
    { x: @row_coordinate, y: @column_coordinate }
  end

  def mine_count
    @count ||= @neighbors.collect { |cell| cell.mined? ? 1 : 0 }.inject(:+)
  end

  def mined?
    @mined
  end

  def set_mine
    @mined = true
  end
end