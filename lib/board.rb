class Board
  attr_reader :mine_field

  def initialize(board_width: 10, mine_count: 9)
    @flag_count = mine_count
    @mine_field = MineField.new(width: board_width, mine_count: mine_count)
  end

  def to_s
    "#{mine_field.to_s}\nFlags left: #{@flag_count}\n\n"
  end

  def record_move(coordinates, action)
    cell = find_cell(coordinates)

    if action == 'c' || action == 'clear'
      cell.clear
    end
  end

  def cell_available?(coordinates)
    candidate_cell = find_cell(coordinates)
    candidate_cell && !candidate_cell.cleared? ? true : false
  end

  private

  def find_cell(coordinates)
    x, y = coordinates.split(',').map(&:to_i)
    mine_field.find(x, y)
  end
end






















