require './minefield.rb'

class Minesweeper
  def initialize
    @test_board = Minefield.new(9, 9)
    @move = []
  end

  def player_move
    puts ''
    print '> '
    @move = []
    move_input = gets.chomp
    if move_input == 'F'
      @move << move_input
    else
      move_input = move_input.strip.split(',')
      move_input.each do |num|
        @move << num.to_i
      end
    end
  end

  def welcome_message
    puts ''
    puts 'Welcome to Minesweeper!'
    puts 'Enter your moves as two numbers separated by a comma, e.g. 1, 3'
    puts "Or enter 'F' to place a flag."
    puts "Enter 'Q' to quit."
  end

  def play
    welcome_message
    @test_board.place_mines(10)
    @test_board.place_mine_indicators
    @test_board.set_all_cell_adjacent_mines
    loop do
      @test_board.render
      player_move
      @test_board.make_move(@move)
      if @test_board.won?
        puts ''
        puts 'You win!'
        exit
      end
    end
  end
end

test = Minesweeper.new
test.play
