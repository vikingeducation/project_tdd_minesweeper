require_relative('board.rb')
require_relative('player.rb')
require_relative('square.rb')
require('colorize')

class Minesweeper
	def initialize(size = 10, num_mines = 9) # Optional paramaters w/ defaults
		@board = Board.new(size, num_mines)
		@player = Player.new(size)
	end

	# Let's play the game!
	def play
		loop do
			move_type = get_move_type
			coords = get_coordinates
			move_type == 1 ? @board.switch_flag(coords) : @board.display_square(coords)
			if move_type == 2
				if @board.is_loss?(coords)
					ending("l")
					break
				end
			end

			if @board.is_victory?
				ending("v")
				break
			end
		end
	end

	def get_move_type
		error_message = nil
		loop do
			@board.render
			move_type = @player.get_move_type(error_message)
			if move_type == false
				error_message = "Invalid input, please enter 1 or 2"
				redo
			else
				return move_type
				break
			end
		end
	end

	def get_coordinates
		error_message = nil
		loop do
			@board.render
			coords = @player.get_coordinates(error_message)
			if coords == false
				error_message = "Invalid input, enter comma separated coordinates"
				redo
			else
				return coords
				break
			end
		end
	end

	def ending(type)
		if type == "v" 			# Then it's a victory
			@board.render
			puts "Congratulations! You found all the mines!"
		elsif type == "l" 	# Then it's a loss
			@board.show_all_mines
			@board.render
			puts "Sorry, you stepped on a mine! Try again"
		end
	end

end

