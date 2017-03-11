module Minesweeper
  class Renderer
    attr_accessor :board

    def initialize(board = nil)
      @board = board.nil? ? nil : board
    end

    def draw_grid
      output = ""
      
      board.grid.each do |row|
        row.each do |cell|
          output += cell.to_s
        end
        output += "\n"
      end

      puts output
    end
  end
end