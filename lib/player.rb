module Minesweeper
  class Player
    VALID_MOVES = %w(c f u q)

    attr_reader :last_move,
                :last_coords

    def initialize
      @last_move = nil
      @last_coords = nil
    end

    # prompts the player for a move.
    # returns true if the move is valid, false otherwise
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
  end
end
