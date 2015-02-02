require_relative 'cell'

class Minefield

  attr_reader :size, :field

  def initialize(size = 10)
    set_field_size(size)
    create_field_with_attributes
  end

  def render
    field.each do |row|
      row.each { |cell| print cell }
      print "\n"
    end
    nil
  end

  def take_turn(turn)
    row = turn[:row]
    column = turn[:column]
    action = turn[:action]
    take_action(row, column, action)
  end

  # GAME ENDING SCENARIOS

  def lost?
    field.flatten.any? { |cell| cell.exploded? }
  end

  def blow_up_board
    field.flatten.each do |cell|
      cell.clear if cell.mine
    end
  end

  def won?
    uncleared_cells == number_of_mines
  end

  def flag_remaining_mines
    field.flatten.each do |cell|
      cell.flag if cell.mine
    end
  end

  def game_over?
    lost? || won?
  end

  # PUBLIC BOARD INFORMATION

  def number_of_mines
    field.flatten.count { |cell| cell.mine }
  end

  def number_of_flags
    field.flatten.count { |cell| cell.flagged }
  end

  def unflagged_mines
    number_of_mines - number_of_flags
  end

  def uncleared_cells
    field.flatten.count { |cell| !(cell.cleared) }
  end

  private

  # INITIALIZE HELPERS

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
    mines_left = mine_calculator
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
          neighbor_cells(row_num,col_num).each do |neighbor|
            neighbor.count_adjacent_mine
          end
        end
      end
    end
  end

  # TAKE TURN HELPERS

  def take_action(row, column, action)
    cell = field[row][column]
    case action
    when "A"
      auto_clear(row,column)
    when "C"
      clear_with_zero_cascade(row,column)
    when "F"
      cell.flag if unflagged_mines > 0
    when "U"
      cell.unflag
    end
  end

  # SMART CLEARING

  def auto_clear(row,col)
    if already_cleared?(row,col) && flags_match_mines?(row,col)
      valid_neighbor_coordinates(row,col).each do |cell|
        row,col = cell[0],cell[1]
        clear_with_zero_cascade(row,col)
      end
    end
  end

  def clear_with_zero_cascade(target_row,target_column)
    target_cell = field[target_row][target_column]
    target_cell.clear
    if target_cell.adjacent_mines == 0
      valid_neighbor_coordinates(target_row,target_column).each do |cell|
        row,col = cell[0],cell[1]
        unless field[row][col].cleared
          clear_with_zero_cascade(cell[0],cell[1])
        end
      end
    end
  end

  def already_cleared?(row,col)
    field[row][col].cleared
  end

  def flags_match_mines?(row,col)
    count_nearby_flags(row,col) == field[row][col].adjacent_mines
  end

  def count_nearby_flags(row,col)
    neighbor_cells(row,col).count { |cell| cell.flagged }
  end

  # FINDING NEIGHBOR CELLS HELPERS

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

  def valid_neighbor_coordinates(row,col)
    coords =  valid_rows(row).each_with_object([]) do |row, nearby|
                valid_cols(col).each do |col|
                  nearby << [row,col]
                end
              end
    coords - [[row,col]]
  end

  def neighbor_cells(row,col)
    valid_neighbor_coordinates(row,col).each_with_object([]) do |cell,neighbors|
      neighbor_row = cell[0]
      neighbor_col = cell[1]
      neighbors << field[neighbor_row][neighbor_col]
    end
  end
end