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
        else
        end
      end
      break
    end
    "boobs"
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
      return false
    end
  end

  def execute_move(coordinates)
    # coordinates are flipped
    puts coordinates.to_s
    cell = @board.board_a[coordinates[1]][coordinates[0]]
    if coordinates[2] == "C"
      puts "something is going horriby horribly wrong here"
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

end
