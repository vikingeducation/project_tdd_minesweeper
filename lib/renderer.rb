module Minesweeper
  class Renderer
    attr_accessor :board

    def initialize(board = nil)
      @board = board.nil? ? nil : board
    end

    def welcome
      puts "Welcome to Minesweeper!"
      puts "I'm sure you've played this before. :)"
      puts "Good luck clearing the minefield!"
      puts
    end

    def prompt_action
      puts "Do you want to (c)lear, (f)lag, (u)nflag a cell; or (r)eset / (q)uit?"
    end
  end
end