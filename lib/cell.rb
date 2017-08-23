module Minesweeper
  class Cell
    attr_reader :column, :row

    class << self
      def cells
        @cells ||= []
      end

      def find(row:, column:)
        cells.detect { |cell| cell.column == column && cell.row == row }
      end
    end


    def initialize(column:, row:)
      @row = row
      @column = column

      self.class.cells << self
    end

    def place_mine
      @mine = true
    end

    def has_mine?
      !!@mine
    end

    def clear
      @cleared = true
    end

    def cleared?
      !!@cleared
    end

    def flag
      @flaged = true
    end

    def flaged?
      !!@flaged
    end

    def number_of_mines_around
      count = 0
      surrounded_cells.each do |row, column|
        cell = Cell.find(row: row, column: column)
        count += 1 if cell&.has_mine?
      end
      count
    end

    def mines_around?
      number_of_mines_around > 0
    end

    def surrounded_cells
      result = []
      ((row - 1)..(row + 1)).each do |row|
        ((column - 1)..(column + 1)).each do |column|
          break if out_of_scope?(row, column)
          result << [row, column]
        end
      end

      result
    end

    private

    def out_of_scope?(row, column)
      size = self.class.cells.map(&:row).max
      row < 0 || row > size || column < 0 || column > size ||
       (column == self.column && row == self.row)
    end
  end
end
