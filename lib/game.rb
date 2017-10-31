require_relative 'board'
require_relative 'cell'

class Game
  attr_accessor :board, :move
  
  def initialize
    @board = Board.new
  end
  
  def make_move
    self.move = gets.chomp.split(',')
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

  def out_of_flags?
    board.flags == 0
  end

  def validate_move
    while not_three_elements? || invalid_action? || out_of_bounds? ||
      already_clear? || already_flagged? || (out_of_flags? && move[2] == 'f')
      binding.pry
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
            cell.show = 'B'.colorize(:red)
          end
        end
      end
    end
  end

  def play
    greeting 
    board.assign_mine_coordinates
    board.compute_adjacent_mines
    loop do 
      
      prompt_for_move
      
      coords = make_move
      if game_over?
        clear_board
        board.render_board
        win? ? (puts "You win!!!") : 
          (puts "**Oh no! You tripped a mine! Bummer!**".colorize(:light_yellow))
        break
      end
      board.update_board(coords)
      board.autoclear_rest_of_board if coords[2] == 'c'
      board.render_board
    end
  end
end


Game.new.play
