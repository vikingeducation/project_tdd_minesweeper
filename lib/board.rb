require_relative 'render'
require_relative 'cell'

class Board
  attr_reader :board, :mines_array, :adjacent_mines_array, :win_time
  attr_accessor :flags, :status

  def initialize(width: 10, mines: 9, mines_array: nil, time_limit: 999)
    raise "Too many mines! (max 30% of area)" if mines > (width**2 * 0.3).to_int
    @width = width
    @mines = mines
    @flags = mines 
    @board = Array.new(width) { Array.new(width, nil ) }
    populate_board_with_cells!
    @mines_array = mines_array || generate_mines
    populate_board_with_mines
    @adjacent_mines_array = determine_adjacent_mines_values
    @time_limit = time_limit
    @start_time = Time.now
    @win_time = nil
  end

  def render
    time_remaining = @time_limit - (Time.now - @start_time).to_int
    puts
    render_top_panel(time_remaining)
    @board.reverse.each_with_index do |row, row_index|
      render_row_labels(row_index)
      row.each do |cell|
        print cell.display
      end
      print "|\n"
    end
    render_column_labels
    puts
  end

  def update_board!(move)
    move_array = move.split
    x_pos = move_array[0].to_i - 1
    y_pos = move_array[1].to_i - 1
    action = move_array[2]
    @flags -= 1 if action == 'f'
    @flags += 1 if action == 'u'
    adjacent_mines_value = @adjacent_mines_array[y_pos][x_pos]
    if adjacent_mines_value.nil? && action == 'c'
      render_all_mines!
    elsif adjacent_mines_value == 0 && action == 'c'
      render_adjacent_cells!(x_pos, y_pos)
    end
    @board[y_pos][x_pos].update_cell!(action, adjacent_mines_value)  # changes display and status of a single cell
    @win_time = (Time.now - @start_time).to_int if win_game?
  end

  # move is a string input 
  # a valid move is in format '# # a' 
  # [1st # -> x, 2nd # -> y, a(action) -> c(clear), f(flag), u(unflag)]
  def valid_move?(move)
    move_array = move.split
    x_pos = move_array[0].to_i
    y_pos = move_array[1].to_i
    action = move_array[2]
    return false unless move_array.size == 3
    return false unless %w(c f u).include?(action)
    return false unless (1..@width).include?(x_pos)
    return false unless (1..@width).include?(y_pos)
    return false unless valid_action_at_cell?(x_pos, y_pos, action)
    true
  end

  def return_board_status
    return 'lost' if mine_cleared?
    return 'lost' if out_of_time?
    return 'won' if win_game?
    'ongoing'   
  end 

  private

  def out_of_time?
    return true if (Time.now - @start_time).to_int == @time_limit
    false
  end

  def mine_cleared?
    @mines_array.each do |pos|
      return true if @board[pos[1]][pos[0]].status == 'cleared'
    end
    false
  end

  def win_game?
    non_mine_cell_positions = get_all_positions - @mines_array
    non_mine_cell_positions.each do |pos|
      return false unless @board[pos[1]][pos[0]].status == 'cleared'
    end
    true
  end

  def render_adjacent_cells!(x_pos, y_pos)
    zero_adjacent_mines = []
    @board[adjacent_y_range(y_pos)].each do |row|
      row[adjacent_x_range(x_pos)].each do |cell|
        if cell.status == 'uncleared' && !cell.mine
          adjacent_mines_value = @adjacent_mines_array[cell.position[1]][cell.position[0]] 
          cell.update_cell!('c', adjacent_mines_value) 
          cell.status = 'cleared'
          if adjacent_mines_value == 0 && cell.position != [x_pos, y_pos]
            zero_adjacent_mines << cell.position
          end
        end
      end
    end
    zero_adjacent_mines.each do |position|
      render_adjacent_cells!(position[0],position[1])
    end
  end

  def render_all_mines!
    @board.each do |row|
      row.each do |cell|
        cell.display = Render::BOMB if cell.mine
      end
    end
  end

  def valid_action_at_cell?(x_pos, y_pos, action)
    cell_status = @board[y_pos-1][x_pos-1].status
    case action
    when 'c'  # can ONLY clear uncleared cells
      cell_status == 'uncleared' ? true : false
    when 'f'  # can ONLY flag uncleared cells and flags > 0
      if cell_status == 'uncleared' && @flags > 0
        true
      else
        false
      end
    when 'u'  # can ONLY unflag flagged cells
      cell_status == 'flagged' ? true : false
    end
  end

  def determine_adjacent_mines_values
    adjacent_mines_array = Array.new(@width) { Array.new(@width, nil ) }
    @board.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        adjacent_mines_array[y][x] = adjacent_mines(x, y) unless cell.mine
      end
    end
    adjacent_mines_array
  end

  def adjacent_mines(x_pos, y_pos)
    mine_ct = 0
    @board[adjacent_y_range(y_pos)].each do |row|
      row[adjacent_x_range(x_pos)].each do |cell|
        mine_ct += 1 if cell.mine
      end
    end
    mine_ct
  end

  def adjacent_x_range(x_pos)
    x_pos-1 < 0 ? x0 = x_pos : x0 = x_pos-1
    x_pos+1 > @width-1 ? x1 = x_pos : x1 = x_pos+1
    x0..x1
  end

  def adjacent_y_range(y_pos)
    y_pos-1 < 0 ? y0 = y_pos : y0 = y_pos-1
    y_pos+1 > @width-1 ? y1 = y_pos : y1 = y_pos+1
    y0..y1
  end

  def get_all_positions
    all_positions = []
    (0..@width-1).each do |x|
      (0..@width-1).each do |y|
        all_positions << [x, y]
      end
    end
    all_positions
  end

  def generate_mines
    get_all_positions.sample(@mines)
  end

  def populate_board_with_mines
    @mines_array.each { |mine| @board[mine[1]][mine[0]].mine = true }
  end

  def populate_board_with_cells!
    (0..@width-1).each do |x|
      (0..@width-1).each do |y|
        @board[y][x] = Cell.new([x, y])
      end
    end
  end

  def render_top_panel(time_remaining)
    render_horizontal_border
    print ''.ljust(3) + '|' 
    print "#{@flags}".rjust(4) + Render::FLAG
    if return_board_status == 'lost'
      print Render::UPSET_FACE.center(4 * (@width-4))
    elsif return_board_status == 'won'
      print Render::SMILING_FACE_WITH_SUNGLASSES.center(4 * (@width-4))
    else
      print Render::SMILING_FACE.center(4 * (@width-4))
    end
    print Render::HOURGLASS + "#{time_remaining.to_s.ljust(4)}" + "|\n"
    render_horizontal_border
  end

  def render_row_labels(row_index)
    print "#{(row_index-@width).abs}".center(3) + '|'
  end

  def render_column_labels
    render_horizontal_border
    print ''.ljust(4)
    @board.each_with_index do |row, row_index|
      print "#{row_index+1}".center(4)
    end
    print "\n"
  end

  def render_horizontal_border
    puts ''.ljust(3) + '-' + '-' * 4 * @width + '-'
  end
end