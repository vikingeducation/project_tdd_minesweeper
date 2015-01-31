require_relative 'cell'

class Minefield

  attr_reader :size, :field, :number_of_mines

  def initialize(size = 10)
    if size.class == Fixnum
      @size = size
    else
      raise 'Please enter an integer.'
    end
    @field = Array.new(size){ Array.new(size){ Cell.new } }
    @number_of_mines = mine_calculator
    generate_mines
  end

  # def winning?
    # return false if field.flatten.any? { |cell| cell.exploded? }
    # field.flatten.all? { |cell| cell.cleared || cell.flagged }
  # end

  private

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

  # def generate_adjacent_mine_counts
  #   field.each_with_index do |row, row_num|
  #     row.each_with_index do |cell, col_num|
  #       if cell.mine
  #         valid_neighbors(row_num,col_num).each do |neighbor|
  #           neighbor.count_adjacent_mine
  #         end
  #       end
  #     end
  #   end
  # end
end