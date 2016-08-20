module Minesweeper
  # Square class
  class Square
    attr_reader :surround, :reveal, :flag, :showing

    def initialize(coord, map)
      @coord = coord
      @surround = count_mines(map)
      @showing = false
      @flag = false
      @mine = false
    end

    def change_flag
      @showing ? nil : @flag = !@flag
    end

    def add_mine
      @mine = true
    end

    def reveal
      @showing = true
      @mine ? false : true
    end

    def count_mines(map)
      (map & surrounding_squares).length
    end

    private

    def surrounding_squares
      arr = []
      x = @coord[0]
      y = @coord[1]
      (x - 1..x + 1).each do |i|
        (y - 1..y + 1).each { |j| arr << [i, j] }
      end
      arr
    end
  end
end
