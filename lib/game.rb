require_relative 'board'
require_relative 'cell'

class Game
  attr_accessor :board, :move
  
  def initialize
    @board = Board.new
  end
  
  def make_move
    self.move = gets.chomp.split(',')
    #self.move[0], self.move[1] = move.[0].to_i, move[1.to_i]
    validate_move
    move
  end

  def not_three_elements?
    move.size > 3 || move.size < 3
  end

  def invalid_action?
    !(move[2] == 'c' || move[2] == 'f')
  end

  def out_of_bounds?
    move[0].to_i > board.board_size || move[1].to_i > board.board_size ||
    move[0].to_i < 1 || move[1].to_i < 1
  end

  def already_clear?
    board.board[move[0].to_i - 1][move[1].to_i - 1].clear == true
  end

  def already_flagged?
    board.board[move[0].to_i - 1][move[1].to_i - 1].flag == true
  end

  def validate_move
    while not_three_elements? || invalid_action? || out_of_bounds? ||
      already_clear? || already_flagged?
      puts "Invalid move, try again."
      make_move
    end
  end

  def greeting
    puts
    puts "**Welcome to Minesweeper!**"
    puts
  end

  def prompt_for_move
    puts "Enter your move"
  end

  def win?
    board.flags == 0 &&
    board.board.all? do |row|
      row.all? { |cell| cell.flag == true || cell.clear == true }
    end
  end

  def lose?
    move[2] == 'c' && 
      board.mine_coordinates.include?([move[0].to_i - 1, move[1].to_i - 1])
  end

  def game_over?
    win? || lose?
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

  def play
    greeting 
    board.assign_mine_coordinates
    p board.mine_coordinates
    board.compute_adjacent_mines
    p board.create_adjacent_mines_board
    loop do 
      
      prompt_for_move
      
      coords = make_move
      if game_over?
        clear_board
        board.render_board
        break
      end
      board.update_board(coords)
      board.autoclear_rest_of_board if coords[2] == 'c'
      #board.autoclear_rest_of_board
      board.render_board
    end
  end
end


#Game.new.play
=begin
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
=end


