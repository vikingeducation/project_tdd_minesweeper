require_relative './player'
require_relative './board'
require_relative './renderer'

module Minesweeper
  class Game
    attr_reader :player,
                :board,
                :renderer

    def initialize(board = nil)
      @player = Player.new
      @board = board || Board.new
      @renderer = Renderer.new(self.board)
    end

    def show_instructions
      puts "Welcome to Minesweeper!"
      puts "You might have played this game before, but here's a refresher:"
      puts "Every turn, you can choose to either clear, flag, or unflag a cell."
      puts "Please choose your action, then enter a coordinate in the format 'row, col'."
      puts "Valid row values range from 0 to #{board.rows}, and valid column values range from 0 to #{board.cols}."
      puts "You win if you successfully clear all cells without clearing a mine."
      puts "Good luck!"
      puts
    end

    def setup
      show_instructions
      board.setup_minefield
      renderer.draw_grid
      renderer.show_flags_left
    end

    def run_loop
      loop do
        # get move
        move = player.get_move

        # exit game if player chooses to quit
        quit if player.last_move == 'q'

        # get coordinates of move
        coords = player.get_coords if move

        # make the move if valid
        player.make_move(board) if move && coords

        # draw the updated grid
        renderer.draw_grid

        # show remaining flags
        renderer.show_flags_left 

        congratulate_player if victory?

        if defeat?
          renderer.draw_grid(show_mines = true)
          console_player
        end

        break if victory? || defeat?
      end
    end

    def quit
      puts "Thank you for playing, goodbye!"
      exit
    end

    def victory?
      board.all_safe_cells_cleared?
    end

    def defeat?
      if player.last_move == 'c'
        row, col = player.last_coords[0], player.last_coords[1]
        return board.cell_cleared?(row, col) && board.cell_has_mine?(row, col) if board.valid_coordinate?(row, col)
      end

      false
    end

    def congratulate_player
      puts "Congratulations, you won!"
    end

    def console_player
      puts "Better luck next time!"
    end
  end
end
