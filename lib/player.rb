module Minesweeper
  class Player
    VALID_MOVES = %w(c f u q)

    attr_reader :last_move,
                :last_coords

    def initialize
      @last_move = nil
      @last_coords = nil
    end

    # Prompts the player for a move.
    # Returns true if the move is valid, false otherwise
    def get_move
      puts "Do you want to (c)lear, (f)lag, (u)nflag, (r)eset, or (q)uit?"
      print "Please enter your move > "

      input = gets.chomp.downcase

      if VALID_MOVES.include?(input)
        @last_move = input
        true
      else
        false
      end
    end

    # Prompts the player for coordinates.
    # Returns true if the input has two elements, false otherwise.
    # Checking whether the coordinates are actually valid is delegated
    # to another class.
    def get_coords
      print "Please enter coordinates in the format 'row, col' > "

      input = gets.chomp.split(/\W+/)

      if input.size == 2
        @last_coords = [input[0].to_i, input[1].to_i]
        true
      else
        false
      end
    end

    def make_move(board)
      row, col = last_coords[0], last_coords[1]

      case last_move
      when 'c'
        board.clear(row, col)
      when 'f'
        board.flag(row, col)
      when 'u'
        board.unflag(row, col)
      end
    end
  end
end
