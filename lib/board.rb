# Class for manipulating and outputting the 
# board itself.

class Board
	attr_reader :flags_remaining
	
	def initialize(size, num_mines)
		@board = create_board(size,num_mines)
		@flags_remaining = num_mines
	end

	# Will create the board nested array
	def create_board(size, num_mines)
		final_board = []
		# Create outer loop
		1.upto(size) do |row|
			row_buffer = []
			# Create inner loop
			1.upto(size) do |column|
				row_buffer << Square.new([column,((size+1)-row)])
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
			if selection.mine 				# If the selection is a mine
				redo
			else											# If the selection isn't a mine
				selection.make_mine 		# then make it a mine
				num_mines -= 1					# and decrement the number of mines left.
			end
		end 
	end
end