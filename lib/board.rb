require 'pry'
#require_relative 'game'
require_relative 'cell'

class Board
  attr_reader :board_size
  attr_accessor :flags, :mine_coordinates, :board
  
  def initialize(board_size = 10, flags = 9)
    @board_size = board_size
    @board = Array.new(@board_size) {Array.new(@board_size) { |cell| Cell.new } }
    @flags = flags
  end

  def assign_mine_coordinates
    @mine_coordinates = []
    @flags.times do 
      row = (0..(@board_size - 1)).to_a.sample
      column = (0..(@board_size   - 1)).to_a.sample
      board[row][column].set_mine
      self.mine_coordinates << [row, column]
    end
    replace_repeat_mine_coordinates
  end

  def replace_repeat_mine_coordinates
    while mine_coordinates.uniq.size < flags 
      self.mine_coordinates.uniq!
      (flags - mine_coordinates.size).times do
        row = (0..(@board_size - 1)).to_a.sample
        column = (0..(@board_size - 1)).to_a.sample
        board[row][column].set_mine
        self.mine_coordinates << [row, column]
      end
    end
  end

  def compute_adjacent_mines
    mine_coordinates.each do |mine|
      surrounding_cells = [[-1, -1], [-1, 0], [-1, 1], 
        [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]].map{|a, b| 
        [a + (mine[0].to_i), b + (mine[1].to_i)] }
      surrounding_cells.each do |coords|
        if coords[0] < 0 || coords[0] > 9 || coords[1] < 0 ||
          coords[1] > 9 
          #binding.pry
          next
        else
          cell = board[coords[0]][coords[1]]
          unless cell.mine == true
            cell.adjacent_mines += 1
          end
        end
      end
    end
  end

  def display_remaining_flags
    puts "#{flags} flags remaining"
    puts 
  end

  def display_column_numbers
    print '   '
    if @board_size <= 10
      @board_size.times { |i| print "#{i + 1}  "}
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
        print "#{(row_index + 1)} "
      else
        print "#{(row_index + 1)}  "
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

  def update_board(coordinates)
    row = coordinates[0].to_i - 1
    column = coordinates[1].to_i - 1
    action = coordinates[2]

    if action.downcase == 'c'
      self.board[row][column].clear_cell
      self.board[row][column].show = check_surrounding_squares(coordinates)
      autoclear_nearby_empty_cells(coordinates) if self.board[row][column].show == 0
    elsif action.downcase == 'f' && board[row][column].clear == false
      if board[row][column].flag == false
        self.board[row][column].set_flag
        self.flags -= 1
      else
        self.board[row][column].unflag
        self.flags += 1
      end
    end     
  end

  def collect_surrounding_cells(coordinates)
    surrounding_cells = []

    surrounding_cell_coords = [[-1, -1], [-1, 0], [-1, 1], 
    [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]].map{|a, b| 
    [a + (coordinates[0].to_i - 1), b + (coordinates[1].to_i - 1)] }

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
    #binding.pry
    surrounding_cells.each do |cell|
      if cell == nil
        next
      else
        cell.clear_cell
        cell.show = cell.adjacent_mines
      end
    end    
  end

  def autoclear_rest_of_board
    board.each_with_index do |row, row_index|
      row.each_with_index do |cell, column_index|
        if cell.adjacent_mines == 0 && cell.clear == true && cell.mine == false
          autoclear_nearby_empty_cells([row_index, column_index])
        end
      end
      #surrounding_cells = collect_surrounding_cells([row_index, column_index])
    #break if surrounding_cells.all? { |cell| cell.adjacent_mines > 1}
  end
end
end


=begin
  
 board.each_with_index do |row, row_index|
      row.each_with_index do |cell, column_index|
        surrounding_cells = collect_surrounding_cells([row_index, column_index])
    while surrounding_cells.any? { |cell| cell.clear == false}
        if cell.adjacent_mines == 0 && cell.clear == true
          autoclear_nearby_empty_cells([row_index, column_index])
        end
      end
    end
  end
  
=end

=begin
mine_coordinates.each do |mine|
      surrounding_cells = [[-1, -1], [-1, 0], [-1, 1], 
        [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]].map{|a, b| 
        [a + (mine[0].to_i - 1), b + (mine[1].to_i - 1)] }
      surrounding_cells.each do |coords|
        if coords[0] < 0 || coords[0] > 9 || coords[1] < 0 ||
          coords[1] > 9 
          binding.pry
          next
        else
        cell = board[coords[0]][coords[1]]
        unless cell.mine == true
          cell.adjacent_mines += 1
        end
      end
      end
    end

=end
=begin

-print 10x10 board
-9 squares contain mines
-user selects square
-if square contains mine, game over
-otherwise, squares that are not adjacent to any mines are cleared and those that are adjacent to mines that are adjacent to the cleared squares are marked with a number indicating how many mines they are adjacent to
-from there, user can flag a square that he/she thinks contains a mine or clear squares that he/she thinks do not contain mines
-game ends if player selects a mined square or if all of the non-mind squares have been cleared and all of the mined squares have been flagged

=end

