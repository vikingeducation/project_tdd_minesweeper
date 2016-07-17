module Minesweeper
  class View
    # icons
    SQUARE = "\u25A1"
    FLAG = "\u2690"
    CHECK = "\u2713"

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
      puts '___' * (grid.size-1)
      grid.each_with_index do |col, x|
        col.each_with_index do |square, y|
          print cursor == [x,y] ? "[" : " "
          if square.showing
            print square.surround > 0 ? "#{square.surround}" : " "
          elsif square.flag
            print "#{FLAG}"
          else
            print "#{SQUARE}"
          end
          print cursor == [x,y] ? "]" : " "
        end
        puts
      end
    end
  end
end
