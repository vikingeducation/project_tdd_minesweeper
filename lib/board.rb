require 'pry'
require 'rainbow'

class Board
  attr_reader :mines, :mine_locations, :remaining_flags, :visible_board, :size

  def initialize(size=10, mines=9, mine_locations=nil, visible_board=nil)
    @mines = mines
    @remaining_flags = mines
    @size = size
    @last_move = nil

    # 0 indicates no mine, 1 indicates mine
    @mine_locations = mine_locations || create_mine_locations(size, mines)

    # blank and white background indicates not yet cleared
    @visible_board = visible_board || Array.new(size){ Array.new(size, Rainbow('   ').bg(:white)) }
  end

  def render
    # TODO: delete this loop
    @mine_locations.each do |row|
      puts row.to_s
    end

    puts Rainbow("Remaining mine flags: ").black.bg(:yellow) + Rainbow("#{@remaining_flags}").red.bg(:yellow)


    puts "\nRow:" + "-" * (@size * 4 + 1)

    (@size-1).downto(0) do |row|
      puts "#{(row+1).to_s.rjust(4)}|" + @visible_board[row].join('|') + '|'
        puts "    " + "-" * (@size * 4 + 1)
    end

    print "Col:"
    (1..@size).each {|c| print "  #{c} "}
  end

  def place_move(move)
    if move_valid?(move)
      reveal_square(move.first - 1, move.last - 1)
      true
    else
      false
    end
  end

  def place_flag(move)
    if move_valid?(move) && spot_open?(move) && flags_left?
      @visible_board[move.first - 1][move.last - 1] = Rainbow(' * ').red.bg(:white)
      @remaining_flags -= 1
      true
    else
      false
    end
  end

  def last_move_bomb?
    @last_move == 1
  end

  private

  def flags_left?
    @remaining_flags > 0 ? true : puts("I'm sorry, you have no flags left.")
  end

  def spot_open?(move)
    if @visible_board[move.first - 1][move.last - 1] == Rainbow('   ').bg(:white)
      true
    else
      puts "I'm sorry, you can only place flags on non-cleared squares. Try again..."
    end
  end

  def create_mine_locations(size, mines)
    @mine_locations = Array.new(size){ Array.new(size, 0) }
    mine = 0
    until mine == mines
      rand_row = rand(0..9)
      rand_col = rand(0..9)
      if @mine_locations[rand_row][rand_col] == 0
        @mine_locations[rand_row][rand_col] = 1
        mine += 1
      end
    end
    @mine_locations
  end

  def move_valid?(move)
    if move.all?{ |location| (1..@size).include?(location)}
      true
    else
      puts "I'm sorry that location doesn't exist on the board. Try again."
    end
  end

  def reveal_square(row, col)
    @last_move = @mine_locations[row][col]
    if @last_move == 1
      show = Rainbow(' * ').black.bg(:red)
    else
      count = get_count(row, col)
      count = ' ' if count == 0
      show = Rainbow(" #{count} ").red
    end
    @visible_board[row][col] = show
  end

  def get_count(row, col)
    nearby_cells = [
      [row - 1, col - 1], [row - 1, col], [row - 1, col + 1],
      [row, col - 1], [row, col + 1],
      [row + 1, col - 1], [row + 1, col], [row + 1, col + 1]
    ]

    # remove any off the board
    nearby_cells.select! do |loc|
      (0..(@size-1)).include?(loc.first) && (0..(@size-1)).include?(loc.last)
    end

    # map to the mine locations and add up the mines
    nearby_cells.map!{|loc| @mine_locations[loc.first][loc.last]}.inject(:+)
  end
end