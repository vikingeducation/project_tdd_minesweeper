require_relative 'board'
require_relative 'cell'

class Game
  attr_accessor :board, :move
  
  def initialize
    @board = Board.new
  end
  
  def make_move
    self.move = gets.chomp.split(',')
    raise 'invalid input' if @move.size < 3
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

  def game_over?
    move[2] == 'c' && board.mine_coordinates.include?([move[0].to_i - 1, move[1].to_i - 1])
  end

  def clear_board
    if game_over?
      board.board.each do |row|
        row.each do |cell|
          if cell.mine == true

            cell.show = 'B'
          end
        end
      end
    end
  end
end



game = Game.new
game.greeting
game.prompt_for_move
game.board.assign_mine_coordinates
p game.board.mine_coordinates
game.board.compute_adjacent_mines
coords = game.make_move
game.clear_board
#game.board.update_board(coords)
#game.board.autoclear_rest_of_board
game.board.render_board



