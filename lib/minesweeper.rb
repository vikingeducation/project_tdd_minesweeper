#Edited
require 'Player'

class Minesweeper
	def initialize
	end

	def game
		board = Board.new(level)
		player = Player.new(board)
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
	   return size, mines
    end
end