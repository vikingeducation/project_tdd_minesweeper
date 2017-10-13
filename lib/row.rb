require_relative 'cell'

class Row

  def build(board_size)
    row = []

    (board_size - 1).times do
      row << Cell.new
    end
    row << Mine.new

    row.shuffle!
  end

end
