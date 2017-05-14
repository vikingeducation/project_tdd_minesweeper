# game.rb
require_relative 'cell'
require_relative 'board'
require 'colorize'

class Game
  attr_accessor :board, :end_game

  #delete me
  attr_accessor :render
  # it creates a board
  def initialize
    @board = Board.new
    @end_game = false
    @render = Renderer.new(@board)
  end

  def play
    loop do
      @render.render_board
      make_move
      check_end_game
      break if @end_game
    end
  end

  def make_move
    loop do
      coordinates = get_coordinates
      if valid_coordinates(coordinates)
        puts "You've chosen #{coordinates[0]}, #{coordinates[1]}"
        move = get_move
        if valid_move(move)
          coordinates << move
          if execute_move(coordinates)
            break
          end
        end
      end
      break
    end
  end

  def get_coordinates
    puts 'Enter coordinates and coordinates in the format "x,y"'
    input = gets.chomp
    if input.upcase == "Q"
      exit
    end
    input.split(",").map(&:to_i)
  end

  def get_move
    puts "Clear (c) or Mark (m) the square"
    gets.chomp.upcase
  end

  def valid_coordinates(move)
    if move.length != 2
      return false
    end
    move.each do |crd|
      if crd < 0 || crd > 9
        return false
      end
    end
    true
  end

  def valid_move(move)
    if move == "M" || move == "C"
      return true
    else
      puts "Invalid move"
      return false
    end
  end

  def execute_move(coordinates)
    cell = @board.board_a[coordinates[0]][coordinates[1]]
    if coordinates[2] == "C"
      cell.clear
    end
    if coordinates[2] == "M"
      if cell.marked == true
        cell.unmark_mine
      elsif cell.marked == false
        cell.mark_mine
        @board.num_flags -= 1
      end
    end
  end

  def check_end_game
    if trip_mine || swept_mines
      @end_game = true
    end
  end

  def trip_mine
    range = (0..((@board.size)-1))
    range.each do |row|
      range.each do |col|
        cell = @board.board_a[row][col]
        if cell.cleared && cell.mine
          @render.clear_board
          @render.render_board
          puts "You tripped a mine! Game over"
          return true
        end
      end
    end
    false
  end

  def swept_mines
    uncleared_cells = 0
    range = (0..((@board.size)-1))
    range.each do |row|
      range.each do |col|
        cell = @board.board_a[row][col]
        if cell.cleared == false
          uncleared_cells += 1
        end
      end
    end
    if uncleared_cells == @board.num_mines
      puts "You've marked all the mines! You win!"
      return true
    end
    false
  end

end
