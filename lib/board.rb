require_relative 'cell'
require 'colorize'
class Board
  attr_accessor :columns, :mines, :start_time, :squares_arr, :mine_arr, :board, :remaining_flags, :game_time
  def initialize(columns, mines)
    @board = Array.new(columns){Array.new(columns)}
    @columns = columns
    @mines = mines
    @remaining_flags = mines
    @start_time = Time.now
    @game_time = time
    @squares_arr = create_squares_arr
    @mine_arr = include_mines
    board_setup
  end

  def render
    current = Time.now.to_f
    puts "TIME: #{"%2d" % (current - @start_time.to_f)} seconds   FLAGS: #{@remaining_flags}"
    print "   "
    @columns.times {|i| print "#{"%2d" % (i + 1)}   "}
    puts
    @columns.times {|k| print "_____"}
    puts
    @columns.times do |i|
      print "#{"%2d" % (i + 1)}| "
      @columns.times do |j|
        print "#{(((@board[i][j]).render_sym.to_s)).colorize((@board[i][j]).color)}    "
      end
      puts
    end
  end

  private
  def time
    mulitiplier = 0.16
    return (@columns / mulitiplier).floor
  end

  def create_squares_arr
    sq_arr = []
    num_squares = @columns ** 2
    num_squares.times do
      sq_arr << "C"
    end
    return sq_arr
  end

  def include_mines
    @mines.times do
      @squares_arr.shift
      @squares_arr << "M"
    end
    return @squares_arr.shuffle!
  end

  def board_setup
    i = 0
    @columns.times do |row|
      @columns.times do |col|
        cell = Cell.new(@mine_arr[i] == "M")
        i += 1
        if (cell.is_mine)
          add_to_adjacents(row, col)
        else
          cell.adj_mine_count += add_to_current(row, col)
        end
        @board[row][col] = cell
      end
    end
  end

  def add_to_adjacents(row, col)
    if (row > 0 && col > 0)
      cell = @board[row - 1][col - 1]
      cell.adj_mine_count += 1
    end
    if (row > 0)
      cell = @board[row - 1][col]
      cell.adj_mine_count += 1
    end
    if (row > 0 && col < @columns - 1)
      cell = @board[row - 1][col + 1]
      cell.adj_mine_count += 1
    end
    if (col > 0)
      cell = @board[row][col - 1]
      cell.adj_mine_count += 1
    end
  end

  def add_to_current(row, col)
    adj_mine_count = 0
    if (row > 0 && col > 0)
      cell = (@board[row - 1][col - 1])
      adj_mine_count += 1 if cell.is_mine
    end
    if (row > 0)
      adj_mine_count += 1 if (@board[row - 1][col]).is_mine
    end
    if (row > 0 && col < @columns - 1)
      adj_mine_count += 1 if (@board[row - 1][col + 1]).is_mine
    end
    if (col > 0)
      adj_mine_count += 1 if (@board[row][col - 1]).is_mine
    end
    return adj_mine_count
  end

end #Board
