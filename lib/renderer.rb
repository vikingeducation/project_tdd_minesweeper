module Minesweeper
  class Renderer
    attr_accessor :board

    def initialize(board = nil)
      @board = board.nil? ? nil : board
    end

    def draw_grid(show_mines = false)
      grid = ""
      grid += column_numbers

      row_num = 0

      board.grid.each do |row|
        row.each do |cell|
          cell.clear if (show_mines && cell.mine)
          grid += "#{cell.to_s} "
        end
        
        grid += "\t#{row_num}\n"
        row_num += 1
      end

      puts
      puts grid
      puts
    end
    
    def show_flags_left
      puts "Flags left: #{board.flags}"
      puts
    end

    private

    def column_numbers
      output = ""

      board.rows.times do |row|
        output += "#{row} "
      end

      output += "\n\n"
    end
  end
end