require_relative "board.rb"
require_relative "Square.rb"
require_relative "Player.rb"
require 'io/console'



class Game
  attr_accessor :board, :player
  def initialize
    @board = Board.new
    @player = Player.new
  end

  def play
    board.render
    action = nil
    loop do
      action = player_input

      if board.update(action) == :gameover
        board.render
        display_loosing_message
        break
      end

      board.render

      if board.winner?
        display_winning_message
        break
      end
    end
  end

  def display_winning_message
    puts "Congratulations! You Win, you uncoverd all the mines"
  end

  def display_loosing_message
    puts "Sorry! You Lose, you stepped on a mine"
  end

  def player_input
    action =  nil
    loop do
      print "Enter commands here>"
      ip = read_char
      case ip
      when "\e[A"
        puts "UP ARROW"
        action = :up
        break
      when "\e[B"
        puts "DOWN ARROW"
        action = :down
        break
      when "\e[C"
        puts "RIGHT ARROW"
        action = :right
        break
      when "\e[D"
        puts "LEFT ARROW"
        action = :left
        break
      when "c"
        puts "CLEAR"
        action = :clear
        break
      when "f"
        puts "FLAG"
        action = :flag
        break
      when "u"
        puts "UNFLAG"
        action = :unflag
        break
      when "q"
        puts "EXIT"
        action = :exit
        exit
      else
        puts "please enter valid input"
      end
    end
    return action
  end

  def read_char
    STDIN.echo = false
    STDIN.raw!

    input = STDIN.getc.chr
    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil
      input << STDIN.read_nonblock(2) rescue nil
    end
  ensure
    STDIN.echo = true
    STDIN.cooked!

    return input
  end

end