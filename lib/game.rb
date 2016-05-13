require_relative 'tile.rb'
require_relative 'board.rb'

class Game
  attr_accessor :board, :flags

  def initialize
    @board = Board.new
    @flags = 9
  end

  def run
    # Game instructions
    puts "This 10x10 grid has 9 mines!\nEnter coordinates to clear mines and get clues.\nWrite 'F' after coordinates to add a flag on suspected mine.\nIf you clear a mine, you're dead!\n\n"
    #loop do
      render_board
      #get_coordinates
    #end
  end

  def render_board
    puts "Board Size: 10 x 10 | Mines: 9 | Flags: #{flags}"
    (0...@board.height).each do |x|
      (0...@board.width).each do |y|
        tile = @board.tiles[x][y]
        if tile.hidden
          print "|   "
        elsif !tile.hidden
          if tile.mine == true
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
  end

end
