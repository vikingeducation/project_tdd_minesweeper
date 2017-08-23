module Minesweeper
  class Renderer
    def initialize
      @pastel = Pastel.new
    end

    def render(board, mode)
      raise ArgumentError unless board.is_a? Board

      data = format_cells(board.data) do |cell|
                 send("cell_in_#{mode}_mode", cell)
             end

      board_renderer(data) + flags_remaining(board) + colors_meaning
    end

    private

    def format_cells(board_data, &block)
      board_data.map.with_index do |row, row_index|
        [row_index] + row.map{ |cell| yield(cell) }
      end
    end

    def board_renderer(board_data)
      table = TTY::Table.new header: [' ', *0...board_data.size], rows: board_data
      renderer = TTY::Table::Renderer::Unicode.new(table)
      renderer.border.separator = :each_row
      renderer.alignments = (0..board_data.size).map { :center }
      renderer.resize = true
      renderer.width = 70
      renderer.render
    end

    def cell_in_active_mode(cell)
      case
      when cell.flaged? then flaged_cell
      when cell.cleared? then cleared_cell(cell)
      else
        uncleared_cell
      end
    end

    def cell_in_over_mode(cell)
      case
      when cell.cleared? && cell.has_mine? then @pastel.on_red('   ')
      when cell.cleared? then cleared_cell(cell)
      when cell.flaged? then flaged_cell(cell)
      when cell.has_mine? then @pastel.on_black('  ')
      else
        uncleared_cell
      end
    end

    def flags_remaining(board)
      "\nflags remaninig: #{board.flags_remaining}"
    end

    def colors_meaning
      "\n" +
      "#{uncleared_cell} uncleared, #{cleared_cell} cleared, " +
      "#{flaged_cell} flaged"
    end

    def cleared_cell(cell = nil)
      number = cell&.number_of_mines_around
      number = number != 0 ? number : ''
      @pastel.black.on_white(" #{number} ")
    end

    def uncleared_cell
      @pastel.on_blue('  ')
    end

    def flaged_cell(cell = nil)
      cell&.has_mine? ? @pastel.on_green('  ') : @pastel.on_yellow('  ')
    end
  end
end
