# game.rb
require_relative 'cell'
require_relative 'board'
require 'colorize'

class Game
  attr_accessor :board
  # it creates a board
  def initialize
    @board = Board.new

  end

  def play
    loop do
      # get_move
      # convert_to_a

      #


      break
    end


  end


  def get_move
    loop do
      puts 'Enter your move'
      move = convert_to_a(gets.chomp)

      # gets string input with gets
      # converts to an array
      # if the array is valid_move
      valid_move(move)
      # execute move
      execute_move
      #
      break
    end

    "boobs"
  end

  def convert_to_a(input)

  end

  def valid_move(input)
    #if it's valid, return true
    #converts to

    #else, return false
    false
  end

  def execute_move(move)
  end

end
