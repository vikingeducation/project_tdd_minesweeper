# Class for manipulating and outputting the 
# board itself.

class Board
	attr_reader :flags_remaining, :board
	
	def initialize(size, num_mines)
		@board = create_board(size,num_mines)
		@flags_remaining = num_mines
		add_surrounding_mines
	end

	# Will create the board nested array
	def create_board(size, num_mines)
		final_board = []
		# Create outer loop
		1.upto(size) do |row|
			row_buffer = []
			# Create inner loop
			1.upto(size) do |column|
				row_buffer << Square.new([column,((size+1)-row)], size)
			end
			# Once each row is composed add it to 
			# the final board.
			final_board << row_buffer
		end
		set_mines(final_board, num_mines) # Now that we have the board, lets add some mines
		final_board
	end

	# Add some mines to the board
	def set_mines(board, num_mines)
		until num_mines == 0
			selection = board.sample.sample
			if selection.mine 				# If the selection is already a mine
				redo
			else											# If the selection isn't a mine
				selection.make_mine 		# then make it a mine
				num_mines -= 1					# and decrement the number of mines left.
			end
		end 
	end

	# Add the surrounding_mines variable to each Square instance
	def add_surrounding_mines
		@board.flatten.each do |square|
			mine_count = 0
			square.adjacent_squares.each do |adj_square|
				mine_count += 1 if get_square(adj_square).mine == true
			end
			square.surrounding_mines=(mine_count)
		end
	end

	# Return a square object based on the coordinates
	def get_square(test_coords)
		@board.flatten.each do |square|
			return square if square.coords == test_coords
		end
	end

	# Add or remove a flag
	def switch_flag(coords)
		square = get_square(coords)
		if square.flag == false 		# If Square isn't flagged already
			square.switch_flag
			@flags_remaining -= 1
		elsif square.flag == true 	# If Square is flagged already
			square.switch_flag
			@flags_remaining += 1
		end
	end

	# Display a square
	def display_square(coords)
		square = get_square(coords)
		if square.displayed == false
			square.display_square
		else
			raise_error ArgumentError
		end
	end

	# Clear the screen
	def clear
		system "clear"
	end
	
	# Render the actual board
	def render
		clear
		output = "MINESWEEPER\n-----------\n#{@flags_remaining} Flags Remaining\n-----------\n"
		# This will iterate through each row
		# on the board.
		@board.each do |row|
			# This will iterate over each square
			row.each do |square|
				if square.displayed == false && square.flag == false
					output << "O"
				elsif square.displayed == false && square.flag == true
					output << "F"
				elsif square.displayed == true
					if square.surrounding_mines == 0
						output << "_"
					else 
						output << square.surrounding_mines.to_s
					end
				end
			end
			output << "\n"
		end
		print output
	end

end