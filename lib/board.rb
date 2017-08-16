module Minesweeper
  class Board
    attr_reader :size, :mines, :flags_left

    def initialize(size: 10, mines: 9, cell: Cell)
      @size = size
      @mines = mines
      @cell = cell
      @flags_left = mines
    end

    def data
      @data ||= create_board
    end

    def flag(row, col)
      data[row][col].flag
      @flags_left -= 1
    end

    def clear(row, col)
      data[row][col].clear
    end

    private

    def create_board
      (0...size).map do |row_index|
        (0...size).map do |col_index|
          cell = @cell.new(row: row_index, column: col_index)
          cell.place_mine if cells_to_place_mines.include?([row_index, col_index])
          cell
        end
      end
    end

    def cells_to_place_mines
      return @combos if @combos

      @combos = []
      until @combos.size == mines
        combo = [rand(0...size), rand(0...size)]
        @combos << combo if !@combos.include?(combo)
      end

      @combos
    end
  end
end
