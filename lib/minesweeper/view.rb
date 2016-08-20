module Minesweeper
  class View
    # icons
    SQUARE = "\u25A1".freeze
    FLAG = "\u2690".freeze
    SKULL = "\u2620".freeze

    def welcome_message
      system('clear')
      'Welcome to Minesweeper!'
    end

    def lose_message
      'Sorry, you lose...'
    end

    def victory_message
      'Congrats! You win!'
    end

    def render_board(grid, cursor)
      system('clear')
      puts ' '+'____' * grid.size + '_'
      grid.each_with_index do |col, x|
        print '|'
        col.each_with_index do |square, y|
          print cursor == [x, y] ? '[' : ' '
          if square.showing
            if !square.reveal
              print SKULL.to_s.light_black + ' '
            else
              show_number(square)
            end
          elsif square.flag
            print FLAG.to_s.light_magenta + ' '
          else
            print SQUARE.to_s + ' '
          end
          print cursor == [x, y] ? ']' : ' '
        end
        puts ' |'
      end
      puts ' '+'____' * grid.size + '_'
      puts 'Use the arrow keys to move around. f = Flag, space = sweep, q = quit'
    end

    def show_number(square)
      case square.surround
      when 1 then print '1 '.blue
      when 2 then print '2 '.green
      when 3 then print '3 '.light_red
      when 4 then print '4 '.yellow
      when 5 then print '5 '.red
      when 6 then print '6 '.cyan
      when 7 then print '7 '.white
      when 8 then print '8 '.light_black
      else
        print '  '
      end
    end
  end
end
