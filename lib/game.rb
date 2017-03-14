require_relative './player'
require_relative './board'
require_relative './renderer'

module Minesweeper
  class Game
    attr_reader :player,
                :board,
                :renderer

    def initialize
      @player = Player.new
      @board = Board.new
      @renderer = Renderer.new(@board)
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
      renderer.draw_grid
      renderer.show_flags_left
    end

    def run_loop
      player.get_move
    end
  end
end