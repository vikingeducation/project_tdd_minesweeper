module Minesweeper
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
      @mine ? nil : @showing = true
    end

    def count_mines(map)
      x = @coord[0]
      y = @coord[1]
      mines = 0
      (x-1..x+1).each do |i|
        (y-1..y+1).each do |j|
          mines += 1 if map.include?([i,j])
        end
      end
      mines
    end
  end
end
