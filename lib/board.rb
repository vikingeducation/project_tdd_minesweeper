# board.rb
require_relative 'cell'
require 'colorize'

class Board
  attr_accessor :board_a, :num_flags
  #returns number of mines
  attr_reader :num_mines, :size
  # initialize
  def initialize(size = 10, num_mines = 9, num_flags = 9)
    # creates an array of arrays containing cells
    @size = size
    @board_a = Array.new(size) {Array.new(size) {Cell.new}}
    @num_mines = num_mines
    @num_flags = num_flags
    assign_mines
    label_near_mines
  end

  # randomly assigns mines to cells
  def assign_mines
    randomizer.each do |num|
      crd = coordinator(num)
      cell = @board_a[crd[0]][crd[1]]
      cell.plant_mine
    end
  end

  #generates an array of randomly selected coordinates
  def randomizer
    output = []
    max = (@size * @size) - 1
    i = 0
    while i < @num_mines
       num = Random.new.rand(max)
       unless output.include?(num)
         output << num
         i += 1
       end
    end
    output.sort
  end


  #This handy tool turns an integer into x, y coordinates for the board
  def coordinator(num)
    if num < 10
      [0, num]
    else
      num.to_s.split('').map(&:to_i)
    end
  end

  # count_near_mines
  def count_near_mines(crd)
    # calculates the number of mines near the cell
    # and returns the value (based on coordinates)
    x = crd[0]
    y = crd[1]
    num_mines = 0
    # cell = board.b_a[x][y]
    offset_a = [[0,-1],[0,1],[1,-1],[1,0],[1,1],[-1,-1],[-1,0],[-1,1]]
    offset_a.each do |offset|
      sur_cell = [x + offset[0], y + offset[1]]
      if in_bounds?(sur_cell)
          if @board_a[sur_cell[0]][sur_cell[1]].mine == true
              num_mines += 1
          end
      end
    end
    num_mines
  end


  def in_bounds?(crds)
    # a helper method for #count_near_mines
    # if crds[0] >= 0 && crds[1] >= 0
    #   true
    # end
    results = []
    crds.each do |val|
      if val.between?(0, (@size - 1))
        results << true
      else
        results << false
      end
    end
    # the code here is a little backwards here
    # if there are any false values the function
    # returns false
    results.include?(false) ? false : true
  end

  def label_near_mines
  #   # updates the cell value with the number
  #   # of near_mines
    range = (0..(@size -1))
    range.each do |row|
      range.each do |col|
        crds = [row, col]
        cell = @board_a[row][col]
        cell.near_mines = count_near_mines(crds)
      end
    end
  end

  def check_cleared_cells
    range = (0..(@size -1))
    range.each do |row|
      range.each do |col|
        crds = [row, col]
        cell = @board_a[row][col]
        if cell.cleared == true && cell.near_mines == 0
          clear_sur_cells(crds)
        end
      end
    end
  end

  def clear_sur_cells(crd)
    x = crd[0]
    y = crd[1]
    offset_a = [[0,-1],[0,1],[1,-1],[1,0],[1,1],[-1,-1],[-1,0],[-1,1]]
    offset_a.each do |offset|
      crds = [x + offset[0], y + offset[1]]
      if in_bounds?(crds)
        sur_cell = @board_a[crds[0]][crds[1]]
        if sur_cell.mine == false
          sur_cell.clear
        end
      end
    end
  end
end


class Renderer
  def initialize(board)
    @board = board
    @board_a = board.board_a
    @size = board.size
    @num_flags = board.num_flags
  end

  def render_board
    # The size of the board
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
    puts " #{@num_flags} flags remaining"
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

# r = Renderer.new(Board.new)
# r.render_board
# r.clear_board
# r.render_board
