#Edited
require 'player'
require 'board'

class Minesweeper
	def initialize
	end

	def game
		difficulty = level
		board = Board.new(difficulty[0], difficulty[1])
		player = Player.new(board)
		row_size = board.flatten.size**(1.0/2)
		loop do
			coord = player.select_move #array
			cell = coord[0]*row_size + coord[1]
			break if board.change_state_of_square(cell)
		end
	end

	def level
	  size = 0
	  mines = 0
	  print "Select level (B)beginner, (I)intermediate, (A)advanced:"
	  selected_level = gets.chomp.upcase
	  difficulty = selected_level[0]
		if difficulty == "B"
	       size = 5
	       mines = 5
	  elsif difficulty == "I"
	      size = 10
	  elsif difficulty == "A"
	      size = 20
	      mines = 20
	  end
	  return [size, mines]
  end

  def save_game


  end



end