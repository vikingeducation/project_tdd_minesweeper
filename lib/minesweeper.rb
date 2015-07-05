require_relative './board.rb'

class Minesweeper

	def play
		puts "Hi! Let's play Minesweeper \n"
		board, size_of_side = pick_level
		board.render_grid
		play_game = true
		#binding.pry
		while play_game
			cell_to_clear = get_cell(size_of_side)
			play_game = board.change_state_of_square(cell_to_clear)
			board.render_grid
		end
		puts "Better luck next time."
	end

	def get_cell(size_of_side)
		puts "Clear (enter column,row i.e. 2,5) :"
		cell_to_clear = gets.chomp.split(",")
		cell_to_clear = (cell_to_clear[0].to_i-1)*size_of_side + (cell_to_clear[1].to_i-1)
		return cell_to_clear
	end

	def pick_level
		get_level = true
		while get_level
			print "Select level: beginner(b), intermediate(i), advanced(a): "
			level = gets.chomp.downcase
			puts level
				case level[0]
					when "b"
						board = Board.new(5, 5)
						side_size = 5
						get_level = false
					when "i"
						board = Board.new(9)
						side_size = 9
						get_level = false
					when "a"
						board = Board.new(20, 15)
						side_size = 20
						get_level = false
					else
						puts "very funny"
				end
		end
		return board, side_size
	end
end

game = Minesweeper.new
game.play