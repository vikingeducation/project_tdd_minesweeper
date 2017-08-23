module Minesweeper
  class Board
    attr_reader :size, :mines, :flags_remaining
    
    def initialize(size: 10, mines: 9, cell: Cell)
      @size = size
      @mines = mines
      @cell = cell
      @flags_remaining = mines
    end

    def data
      @data ||= create_board
    end

    def flag(row, col)
      data[row][col].flag
      @flags_remaining -= 1
    end

    def clear(row, col, cleared_cells = [], clear = true)
      cleared_cells << [row, col]
      cell = data[row][col]

      if cell.has_mine?
        cell.clear if clear == true
        return @cleared_mine = true
      end

      cell.clear

      if cell.number_of_mines_around.zero?
        surrounded_cells = cell.surrounded_cells - cleared_cells

        surrounded_cells.each do |_cell|
          clear(*_cell, cleared_cells, false)
        end
      end
    end

    def cleared_mine?
      !!@cleared_mine
    end

    def all_cleared?
      data.flatten.all? { |cell| cell.cleared? || cell.flaged? }
    end

    def valid_move?(row, column)
      (0...size).cover?(row) && (0...size).cover?(column) &&
      !data[row][column].cleared? && !data[row][column].flaged?
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
