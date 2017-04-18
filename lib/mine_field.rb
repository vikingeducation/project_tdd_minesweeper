class MineField

  def initialize(width:, mine_count:)
    @width = width
    @mine_count = mine_count
    @field = initialize_mine_field
  end

  def find(x, y)
    field.find do |cell|
      cell.coordinates[:x] == x && cell.coordinates[:y] == y
    end
  end

  def each
    @field.each_with_object([]) do |cell, arr|
      arr << yield(cell)
    end
  end

  def size
    @field.size
  end

  def to_s
    top_row = Array.new(@width) { |i| i + 1 }.join(' | ')
    row_separator = "   -----------------------------------------\n"

    header_string = "   | #{top_row}|\n"
    header_string += row_separator

    board_as_string = header_string + render_cell_rows(row_separator)

    board_as_string
  end

  private

  attr_reader :field

  def create_field
    field = Array.new(@width) do |row|
      Array.new(@width) do |col|
        Cell.new(row: row + 1, col: col + 1)
      end
    end.flatten

    place_mines(field)
  end

  def initialize_mine_field
    create_field
  end

  def place_mines(field)
    @mine_count.times do
      loop do
        cell = field.sample

        unless cell.mined?
          cell.set_mine
          break
        end
      end
    end

    field
  end

  def render_cell_rows(row_separator)
    board_str = ''
    @width.times do |row|
      x = row + 1
      board_str += x < 10 ? "#{x}  |" : "#{x} |"

      @width.times do |col|
        y = col + 1
        board_str += " #{find(x, y).contents} |"
      end
      board_str += "\n" + row_separator
    end

    board_str
  end

end
