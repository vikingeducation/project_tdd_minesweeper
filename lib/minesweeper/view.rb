module Minesweeper
  class View
    # icons
    SQUARE = "\u25A1"
    FLAG = "\u2690"
    SKULL = "\u2620"

    def welcome_message
      system("clear")
      "Welcome to Minesweeper!"
    end

    def lose_message
      "Sorry, you lose..."
    end

    def victory_message
      "Congrats! You win!"
    end

    def render_board(grid, cursor)
      system("clear")
      puts '___' * (grid.size) + '__'
      grid.each_with_index do |col, x|
        print '|'
        col.each_with_index do |square, y|
          print cursor == [x,y] ? "[" : " "
          if square.showing
            if !square.reveal
              print "#{SKULL}"
            else
              print square.surround > 0 ? "#{square.surround}" : " "
            end
          elsif square.flag
            print "#{FLAG}"
          else
            print "#{SQUARE}"
          end
          print cursor == [x,y] ? "]" : " "
        end
        puts '|'
      end
      puts '___' * (grid.size) + '__'
      puts "Use the arrow keys to move around. f = Flag, space = sweep, q = quit"
    end
  end
end
