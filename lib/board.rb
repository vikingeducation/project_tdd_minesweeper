class Board
  attr_reader :mine_field

  def initialize(board_width: 10, mine_count: 9)
    @board_width = board_width
    @mine_count = @flag_count = mine_count
    @mine_field = initialize_mine_field
  end

  def to_s
    top_row = Array.new(@board_width) {|i| i + 1}
    row_separator = "   -----------------------------------------\n"

    header_string = "   | #{top_row.join(' | ')}|\n"
    header_string += row_separator

    board_as_string = header_string + render_cell_rows(row_separator)
    board_as_string += "\nFlags left: #{@flag_count}\n"

    board_as_string
  end

  private

  def find_cell(x, y)
    mine_field.find {|cell| cell.coordinates[:x] == x && cell.coordinates[:y] == y}
  end

  def initialize_mine_field
    Array.new(@board_width) do |row|
      Array.new(@board_width) do |col|
        Cell.new(row: row + 1, col: col + 1)
      end
    end.flatten
  end

  def render_cell_rows(row_separator)
    board_str = ''
    @board_width.times do |row|
      x = row + 1
      board_str += x < 10 ? "#{x}  |" : "#{x} |"

      @board_width.times do |col|
        y = col + 1
        board_str += " #{find_cell(x, y).contents} |"
      end
      board_str += "\n" + row_separator
    end

    board_str
  end

end