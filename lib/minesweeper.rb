 require_relative "player"
require_relative "board"

class Minesweeper
  attr_reader :player, :board
  
  def initialize
    @player = Player.new
    @board = Board.new
  end

  def display_instructions
    puts "Welcome to Minesweeper!"
    puts "*" * 23
    puts "Open all squares without stepping on a mine to win!"
    puts "Here is the current board:"
  end

  def first_move
    display_instructions
    @board.display_board
    @player.row_move
    @player.col_move
    @player.set_coordinates(@player.row, @player.column)
    @board.set_mines(@player.row, @player.column)
    @board.open_square(@player.row, @player.column)
    @board.auto_clear(@player.row, @player.column)
  end

  def play
    loop do
      @player.open_or_flag
      until @player.valid_response?(@player.response) do 
        @player.open_or_flag
      end
      @player.set_marker(@player.response)
      @player.row_move
      @player.col_move
      @player.set_coordinates(@player.row, @player.column)
      until @board.valid_square?(@player.row, @player.column) do
        puts "Square is already opened or flagged!"
        @player.row_move
        @player.col_move
        @player.set_coordinates(@player.row, @player.column)
      end 
      @player.marker == :O ? @board.open_square(@player.row, @player.column) : 
        @board.set_flag(@player.row, @player.column)
      @board.auto_clear(@player.row, @player.column)
        break if @board.win?
    end

    @board.display_win  
  end

end