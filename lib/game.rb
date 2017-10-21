require_relative 'board'

class Game
  attr_accessor :board
  
  def initialize
    @board = Board.new
  end
  
  def make_move
    move = gets.chomp.split(',')
    raise 'invalid input' if move.size < 3
    move
  end

  def greeting
    puts
    puts "**Welcome to Minesweeper!**"
    puts
  end

  def prompt_for_move
    puts "Enter your move"
  end
end



@game = Game.new
@game.board.assign_mine_coordinates
@game.board.compute_adjacent_mines
coords = @game.make_move
@game.board.update_board(coords)
@game.board.render_board
@game.board.render_mine_board




