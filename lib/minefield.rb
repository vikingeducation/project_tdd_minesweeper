require_relative 'cell'

class Minefield

  attr_reader :size, :field, :number_of_mines

  def initialize(size = 10)
    set_field_size(size)
    create_field_with_attributes
  end

  # def winning?
    # return false if field.flatten.any? { |cell| cell.exploded? }
    # field.flatten.all? { |cell| cell.cleared || cell.flagged }
  # end

  private

  def set_field_size(size)
    if size.class == Fixnum
      @size = size
    else
      raise 'Please enter an integer.'
    end
  end

  def create_field_with_attributes
    @field = Array.new(size){ Array.new(size){ Cell.new } }
    @number_of_mines = mine_calculator
    generate_mines
    generate_adjacent_mine_counts
  end

  def mine_calculator
    if size < 20
      9
    else
      100
    end
  end

  def generate_mines
    mines_left = number_of_mines
    until mines_left == 0
      row = rand(size)
      col = rand(size)
      unless field[row][col].mine
        field[row][col].place_mine
        mines_left -= 1
      end
    end
  end

  def generate_adjacent_mine_counts
    field.each_with_index do |row, row_num|
      row.each_with_index do |cell, col_num|
        if cell.mine
          valid_neighbors(row_num,col_num).each do |neighbor|
            neighbor.count_adjacent_mine
          end
        end
      end
    end
  end

  def valid_neighbors(row,col)
    neighbors = valid_rows(row).each_with_object([]) do |row, nearby|
                  valid_cols(col).each do |col|
                    nearby << field[row][col]
                  end
                end
    neighbors - [field[row][col]]
  end

  def valid_rows(row)
    rows = [row]
    rows << (row - 1) unless row == 0
    rows << (row + 1) unless row == (size - 1)
    rows
  end

  def valid_cols(col)
    cols = [col]
    cols << (col - 1) unless col == 0
    cols << (col + 1) unless col == (size - 1)
    cols
  end
end