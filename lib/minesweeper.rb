#Edited
require_relative './player.rb'
require_relative './board.rb'
require 'yaml'

class Minesweeper
	def initialize(filename = false)
		@load_saved_game = filename
	end

	def game
		board = start_a_game
		player = Player.new(board)
		coord = 1
		loop do
			board.render
			coord = player.select_move #array
			break if coord == 00
			cell = (coord[0]-1)*board.size + (coord[1]-1)
			break if board.change_state_of_square(cell)
		end
		save_game(board) if coord == 00
	end

	def start_a_game
		if @load_saved_game
			board = load_file
		else
			difficulty = level
			board = Board.new(difficulty[0], difficulty[1])
		end
	end

	def level
	  size,mines = 0,0
	  print "Select level (B)beginner, (I)intermediate, (A)advanced:"
	  selected_level = gets.chomp.upcase
		if selected_level[0] == "B"
	    size,mines = 5,5
	  elsif selected_level[0] == "I"
	    size = 10
	  elsif selected_level[0] == "A"
	    size, mines = 20, 20
	  end
	  [size, mines]
  end

  def load_file
  	print "Filename? "
	  fname = gets.strip
	  YAML.load(File.read(fname))
  end

  def save_game(board)
	  puts "Save game? [Y,N]"
		save = gets.chomp
	  if save == "Y"
			print "Filename? "
			fname = gets.strip
			File.open(fname,"w") do |file|
				file.write board.to_yaml
		 	end
		end
	end
end

a = Minesweeper.new
a.game