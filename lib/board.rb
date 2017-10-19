require 'pry'

class Board
  attr_reader :board, :board_size
  attr_accessor :flags, :flag_coordinates
  
  def initialize(board_size = 11, flags = 9)
    @board_size = board_size
    @board = Array.new(@board_size) {Array.new(@board_size) { |cell| '*' } }
    @flags = flags
  end

  def assign_flag_coordinates
    @flag_coordinates = []
    @flags.times do 
      row = (0..(@board_size - 1)).to_a.sample
      column = (0..(@board_size - 1)).to_a.sample
      @flag_coordinates << [row, column]
    end
    replace_repeat_flag_coordinates
  end

  def replace_repeat_flag_coordinates
    while flag_coordinates.uniq.size < flags 
      self.flag_coordinates.uniq!
      (flags - flag_coordinates.size).times do 
        row = (0..(@board_size - 1)).to_a.sample
        column = (0..(@board_size - 1)).to_a.sample
        @flag_coordinates << [row, column]
      end
    end
  end

  def render_board
    puts "#{flags} flags remaining"
    puts 
    print '   '
    if @board_size <= 10
      @board_size.times { |i| print "#{i + 1}  "}
    else
      col_num = 0
      9.times do
        col_num += 1
        print "#{col_num}  "
      end
      (@board_size - 9).times do
        print "#{col_num + 1} "
        col_num += 1
      end
    end
    puts
    puts
    board.each_with_index do |row, row_index|
      if row_index >= 9 
        print "#{(row_index + 1)} "
      else
        print "#{(row_index + 1)}  "
      end
      row.each do |cell|
        print cell + '  '
      end
      puts
      puts
    end
  end
end

Board.new.render_board





=begin

-print 10x10 board
-9 squares contain mines
-user selects square
-if square contains mine, game over
-otherwise, squares that are not adjacent to any mines are cleared and those that are adjacent to mines that are adjacent to the cleared squares are marked with a number indicating how many mines they are adjacent to
-from there, user can flag a square that he/she thinks contains a mine or clear squares that he/she thinks do not contain mines
-game ends if player selects a mined square or if all of the non-mind squares have been cleared and all of the mined squares have been flagged

=end

