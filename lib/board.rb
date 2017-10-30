require 'pry'
#require_relative 'game'
require_relative 'cell'

class Board
  attr_reader :board_size, :surrounding_cell_offset
  attr_accessor :flags, :mine_coordinates, :board
  
  def initialize(board_size = 10, flags = 9)
    @board_size = board_size
    @board = Array.new(@board_size) {Array.new(@board_size) { |cell| Cell.new } }
    @flags = flags
    @surrounding_cell_offset = [[-1, -1], [-1, 0], [-1, 1], 
    [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]
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
=begin
  def compute_adjacent_mines
    mine_coordinates.each do |mine|
      surrounding_cells = surrounding_cell_offset.map{|a, b| 
    [a + mine[0].to_i, b + mine[1].to_i] }
      surrounding_cells.each do |coords|        
        if coords[0] < 0 || coords[0] > 9 || coords[1] < 0 ||
          coords[1] > 9 
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
=end

  def compute_adjacent_mines
    mine_coordinates.each do |mine|
      surrounding_cells = collect_surrounding_cells([mine[0] + 1, mine[1] + 1])
      surrounding_cells.each do |cell| 
           
      
          unless cell.mine == true

            cell.adjacent_mines += 1
            #binding.pry 
          end
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
    puts
    puts "**#{flags} flags remaining**"
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

  def update_clear(row, column)
    self.board[row][column].clear_cell
    self.board[row][column].show = board[row][column].adjacent_mines 
    autoclear_nearby_empty_cells([row, column]) if self.board[row][column].show == 0
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

    surrounding_cell_coords = surrounding_cell_offset.map{|a, b| 
    [a + (coordinates[0].to_i - 1), b + (coordinates[1].to_i - 1)] }

    #binding.pry

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
    surrounding_cell_coords = surrounding_cell_offset.map{|a, b| 
    [a + (coordinates[0].to_i - 1), b + (coordinates[1].to_i - 1)] }.delete_if{ 
      |cell| cell[0] < 0 || cell[1] < 0}



    surrounding_cells = collect_surrounding_cells(coordinates)
    #while surrounding_cells.any? { |cell| cell.adjacent_mines == 0 }
    #while surrounding_cell_coords != nil
    surrounding_cells.each_with_index do |cell, index|
      if cell == nil
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
    #binding.pry
  end

  def autoclear_rest_of_board
    
    loop do 
      break_loop = true
      board.each_with_index do |row, row_index|
        row.each_with_index do |cell, column_index|
          if cell.adjacent_mines == 0 && cell.mine == false && cell.clear == true 
            #autoclear_nearby_empty_cells([row_index + 1, column_index + 1])
            surrounding_cells = collect_surrounding_cells([row_index + 1, column_index + 1])
            #binding.pry
            if surrounding_cells.any? { |cell| cell.clear == false && cell.mine == false }#{ |cell| cell.adjacent_mines == 0 && cell.clear == false && cell.mine == false }
              autoclear_nearby_empty_cells([row_index + 1, column_index + 1])
              #board[row_index][column_index].clear_cell
              break_loop = false
            end
          end
        end
      end
      break if break_loop
    end
  end
end
