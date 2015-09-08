require_relative 'board'

class Game
  attr_accessor :board, :play_coord

  def initialize
    @board = Board.new
  end

  def play
    board.render
    loop do
      prompt_move

      if flag_move?
        board.flag_cell(@play_coord)
      else
        execute_move(@play_coord)
      end
      board.render

      if(board.loss)
        puts "You have lost!"
        break
      end

      if(board.win?)
        puts "You have won!"
        break
      end
    end
  end

  def prompt_move
    loop do
      print "Enter the coordinate you wish to 'click' in the form of 'x,y' 
      where 0,0 is the top left corner: "
      coord = gets.chomp.split(",")
      coord[0] = coord[0].to_i
      coord[1] = coord[1].to_i

      if board.cell_shown?(coord)
          puts "This cell is already shown. Please try again."
          next
      else
        @play_coord = coord
        break
      end
    end

    @play_coord
  end

  def flag_move?
    print "Do you wish to flag this coordinate? ('y' for yes, anything else for no): "
    if gets.chomp.downcase == 'y'
      true
    else
      false
    end
  end

  def execute_move(coord)
    @board.click_cell(coord)
  end
end