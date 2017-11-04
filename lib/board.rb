require 'pry'
require_relative 'cell'
require 'colorize'

class Board
  attr_reader :board_size, :surrounding_cell_offset
  attr_accessor :flags, :mine_coordinates, :board

  def initialize(board_size = 10, flags = 9)
    @board_size = board_size
    @board = Array.new(@board_size) { Array.new(@board_size) { Cell.new } }
    @flags = flags
    @surrounding_cell_offset = [[-1, -1], [-1, 0], [-1, 1],
                                [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]
  end

  def assign_mine_coordinates
    @mine_coordinates = []
    @flags.times do
      row = (0..(@board_size - 1)).to_a.sample
      column = (0..(@board_size - 1)).to_a.sample
      board[row][column].set_mine
      mine_coordinates << [row, column]
    end
    replace_repeat_mine_coordinates
  end

  def replace_repeat_mine_coordinates
    while mine_coordinates.uniq.size < flags 
      mine_coordinates.uniq!
      (flags - mine_coordinates.size).times do
        row = (0..(@board_size - 1)).to_a.sample
        column = (0..(@board_size - 1)).to_a.sample
        board[row][column].set_mine
        mine_coordinates << [row, column]
      end
    end
  end

  def compute_adjacent_mines
    mine_coordinates.each do |mine|

      surrounding_cells = collect_surrounding_cells([mine[0] + 1, mine[1] + 1])

      surrounding_cells.each do |cell|
        cell.adjacent_mines += 1 unless cell.mine == true
      end
    end
  end

  def create_adjacent_mines_board
    adjacent_mines_board = []
    board.each do |row|
      adjacent_mines_row = []
      row.each do |cell|
        adjacent_mines_row << cell.adjacent_mines
      end
      adjacent_mines_board << adjacent_mines_row
    end
    adjacent_mines_board
  end

  def display_remaining_flags
    puts '++++++++++++++++++++++++++++'.colorize(:light_green)
    puts "**#{flags} flags remaining**".colorize(:light_green)
    puts '++++++++++++++++++++++++++++'.colorize(:light_green)
  end

  def display_column_numbers
    print '   '
    if @board_size <= 10
      @board_size.times { |i| print "#{i + 1}  ".colorize(:light_yellow) }
    else
      col_num = 0
      9.times do
        col_num += 1
        print "#{col_num}  "
      end
      (@board_size - 9).times do
        print "#{col_num + 1} "
        col_num += 1
      end
    end
    puts
    puts
  end

  def display_rows
    board.each_with_index do |row, row_index|
      if row_index >= 9
        print "#{(row_index + 1)} ".colorize(:light_yellow)
      else
        print "#{(row_index + 1)}  ".colorize(:light_yellow)
      end
      row.each do |cell|
        print "#{cell.show}  "
      end
      puts
      puts
    end
  end

  def render_board
    display_remaining_flags
    display_column_numbers
    display_rows
  end

  def update_clear(row, column)
    board[row][column].clear_cell
    board[row][column].show = board[row][column].adjacent_mines
    autoclear_nearby_empty_cells([row, column]) if board[row][column].show.zero?
  end

  def update_flag(row, column)
    if board[row][column].flag == false
      board[row][column].set_flag
      self.flags -= 1
    else
      board[row][column].unflag
      self.flags += 1
    end
  end

  def update_board(coordinates)
    row = coordinates[0].to_i - 1
    column = coordinates[1].to_i - 1
    action = coordinates[2]

    if action.downcase == 'c'
      update_clear(row, column)
    elsif action.downcase == 'f' && board[row][column].clear == false
      update_flag(row, column)
    end     
  end

  def collect_surrounding_cells(coordinates)
    surrounding_cells = []

    surrounding_cell_coords = surrounding_cell_offset.map do |a, b|
      [a + (coordinates[0].to_i - 1), b + (coordinates[1].to_i - 1)]
    end

    surrounding_cell_coords.each do |coords|
      unless coords[0] < 0 || coords [0] > 9 || coords[1] < 0 || coords[1] > 9
        surrounding_cells << board[coords[0]][coords[1]]
      end
    end
    surrounding_cells
  end

  def check_surrounding_squares(coordinates)
    mines = 0
    surrounding_cells = collect_surrounding_cells(coordinates)
    surrounding_cells.each do |cell|
      mines += 1 if cell.mine == true
    end
    mines
  end

  def autoclear_nearby_empty_cells(coordinates)
    surrounding_cells = collect_surrounding_cells(coordinates)

    surrounding_cells.each do |cell|
      if cell.nil?
        next
      else
        cell.clear_cell
        if cell.adjacent_mines > 0
          cell.show = cell.adjacent_mines
        else
          cell.show = ' ' if cell.mine == false
        end
      end
    end
  end

  def autoclear_rest_of_board
    loop do
      break_loop = true
      board.each_with_index do |row, row_index|
        row.each_with_index do |loc, column_index|
          if loc.adjacent_mines.zero? && loc.mine == false && loc.clear == true
    
            surrounding_cells = collect_surrounding_cells([row_index + 1, column_index + 1])
        
            if surrounding_cells.any? { |cell| cell.clear == false && cell.mine == false }
              autoclear_nearby_empty_cells([row_index + 1, column_index + 1])
              break_loop = false
            end
          end
        end
      end
      break if break_loop
    end
  end
end
