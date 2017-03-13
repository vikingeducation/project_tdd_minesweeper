module Minesweeper
  class Player
    attr_reader :last_move,
                :last_coords

    def initialize
      @last_move = nil
      @last_coords = nil
    end
  end
end