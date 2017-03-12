module Minesweeper
  class Renderer
    attr_accessor :board

    def initialize(board = nil)
      @board = board.nil? ? nil : board
    end

    def draw_grid(show_mines = false)
      grid = ""
      
      board.grid.each do |row|
        row.each do |cell|
          cell.clear if (show_mines && cell.mine)
          grid += cell.to_s
        end
        grid += "\n"
      end

      puts grid
    end
    
    def show_flags_left
      puts "Flags left: #{board.flags}"
      puts
    end
  end
end