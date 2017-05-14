# renderer
require_relative 'board'
class Renderer
  def initialize(board)
    @board = board
    @board_a = board.board_a
    @size = board.size
  end

  def render_board
    # The size of the board
    puts " #{@board.num_flags} flags remaining"
    @board.check_cleared_cells
    range = (0..(@size -1))
    #
    line_brk = "   "
    @size.times {line_brk << "----"}
    top = "    "
    # creates an index on the top
    range.each {|e| top << "#{e}   "}
    puts
    puts top
    puts line_brk
    range.each do |row|
      new_row = " #{row}|"
      range.each do |col|
        cell = @board_a[col][row]
        symbol = get_symbol(cell)
        # puts "The symbol in row #{row} and column #{cell.cleared} is the cleared state"
        new_row << " #{symbol}|"
      end
      puts new_row
      puts line_brk
    end
    puts
  end

  # get_symbol
  def get_symbol(cell)
    #analyes the cell value and returns the appropriate string
    symbol = "# "
    # cell.marked ? symbol = "&" :
    if cell.marked
      symbol = "^|"
    end
    if cell.cleared && cell.near_mines > 0
      symbol = cell.near_mines.to_s + " "
      if cell.near_mines == 1
        symbol = symbol.blue
      end
      if cell.near_mines == 2
        symbol = symbol.green
      end
      if cell.near_mines == 3
        symbol = symbol.red
      end
    end
    if cell.cleared && cell.near_mines == 0
      symbol = "  "
    end
    if cell.mine && cell.cleared
      symbol = "* "
    end
    return symbol
  end

  def clear_board
    # a helper method to reveal the board
    # to be used when player touches a mine
    range = (0..(@size -1))
    range.each do |row|
      range.each do |col|
        cell = @board_a[col][row]
        cell.clear
      end
    end
  end

end
