require 'pry'
require 'rainbow'

class Board
  attr_reader :mines, :board, :remaining_flags, :visible_board, :size

  def initialize(board=nil, visible_board=nil, mines=9, size=10)
    @mines = mines
    @remaining_flags = 9
    @size = size

    # 0 indicates no mine, 1 indicates mine
    @board ||= create_board(size, mines)

    # blank indicates not yet cleared
    @visible_board ||= Array.new(size){ Array.new(size, Rainbow('   ').bg(:white)) }
  end

  def render
    # TODO: delete this loop
    @board.each do |row|
      puts row.to_s
    end

    puts Rainbow("Remaining mines: ").black.bg(:yellow) + Rainbow("#{@remaining_flags}").red.bg(:yellow)

    puts "    Column:"
    print "    "
    (1..@size).each {|c| print "  #{c} "}
    puts "\nRow " + "-" * (@size * 4 + 1)

    (@size-1).downto(0) do |row|
      puts "#{(row+1).to_s.rjust(4)}|" + @visible_board[row].join('|') + '|'
        puts "    " + "-" * (@size * 4 + 1)
    end
  end

  private

  def create_board(size, mines)
    @board = Array.new(size){ Array.new(size, 0) }
    mine = 0
    until mine == mines
      rand_row = rand(0..9)
      rand_col = rand(0..9)
      if @board[rand_row][rand_col] == 0
        @board[rand_row][rand_col] = 1
        mine += 1
      end
    end
    @board
  end

end