require_relative 'cell'

class Row

  def build(board_size)
    cell_qty = board_size - 1

    row = Array.new(cell_qty) { Cell.new }
    row << Mine.new
    row.shuffle!
  end

end
