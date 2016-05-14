require_relative 'tile.rb'
require_relative 'board.rb'

class Game
  attr_accessor :board, :flags, :no_explosions

  def initialize
    @board = Board.new
    @flags = 9
    @no_explosions = true
  end

  def run
    # Game instructions
    puts "This 10x10 grid has 9 mines!\nEnter coordinates to clear mines and get clues.\nWrite 'F' after coordinates to add a flag on suspected mine.\nIf you clear a mine, you're dead!\n\n"
    while @no_explosions
      render_board
      get_coordinates
      break if winner
    end
  end

  def render_board
    puts "Board Size: 10 x 10 | Mines: 9 | Flags: #{flags}"
    (0...@board.height).each do |x|
      (0...@board.width).each do |y|
        tile = @board.tiles[x][y]
        if tile.hidden
          print "|   "
        elsif tile.hidden == false
          if tile.flag == true
            print "| F "
          elsif tile.mine == true
            print "| * "
          else
            print "| #{tile.neighboring_mines} "
          end
        end
      end
      puts
    end
  end

  def get_coordinates
    print "Enter your coordinates > "
    input = gets.chomp
    process_input(input)
  end

  def process_input(input)
    coordinates = input.split
    x = coordinates[0].to_i
    y = coordinates[1].to_i
    flag = coordinates[2]
    make_move(x,y,flag)
  end

  def make_move(x,y,flag)
    tile = @board.tiles[x][y]
    if flag == "F"
      tile.hidden = false
      tile.flag = true
      @flags -= 1
    else
      check_for_mine(x,y)
    end
  end

  def check_for_mine(x,y)
    tile = @board.tiles[x][y]
    if tile.mine == true
      puts "A mine has exploded!"
      @no_explosions = false
    else
      tile.hidden = false
    end
  end

  def winner
    return false if @flags > 0
    if @flags == 0 && correct_flags
      puts "You have won the game!"
      return true
    else
      puts "You haven't died, but some of your mine flags are on the wrong tiles. Game over."
      return true
    end
  end

  def correct_flags
    counter = 0
    (0...@board.height).each do |x|
      (0...@board.width).each do |y|
        tile = @board.tiles[x][y]
        if tile.flag && tile.mine
          counter += 1
        end
      end
    end
    return true if counter == 9
    return false
  end

end
