# Class for manipulating and outputting the 
# board itself.

class Board
	attr_reader :flags_remaining, :board, :mine_coords
	
	def initialize(size, num_mines)
		@size = size
		@board = create_board(size,num_mines)
		@flags_remaining = num_mines
		@mine_coords = get_all_mines
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
			if square.surrounding_mines == 0
				square.adjacent_squares.each do |coords|
					square = get_square(coords)
					display_square(square.coords) unless square.mine == true
				end
			end
		end
	end

	# Get coords of all mines
	def get_all_mines
		all_mines = []
		@board.flatten.each do |square|
			all_mines << square.coords if square.mine == true
		end
		all_mines
	end

	def get_all_flags
		all_flags = []
		@board.flatten.each do |square|
			all_flags << square.coords if square.flag == true
		end
		all_flags
	end

	# Is loss?
	def is_loss?(coords)
		square = get_square(coords)
		square.mine ? true : false
	end

	# Is victory?
	def is_victory? 
		all_flags = get_all_flags
		@mine_coords.all?{|mine_coord| all_flags.include?(mine_coord)} ? true : false
	end

	# Show all mines
	def show_all_mines
		@board.flatten.each do |square|
			if square.mine == true
				square.displayed = true
			end
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
		@board.each_with_index do |row, index|
			index == 0 ? output << "#{@size - index} | " : output << "#{@size - index}  | "
			# This will iterate over each square
			row.each do |square|
				if square.displayed == false && square.flag == false
					output << "O"
				elsif square.displayed == false && square.flag == true
					output << "F".green
				elsif square.displayed == true && square.mine == true && square.flag == true
					output << "F".green
				elsif square.displayed == true && square.mine == true
					output << "M".red
				elsif square.displayed == true
					if square.surrounding_mines == 0
						output << "_"
					elsif square.surrounding_mines == 1
						output << "1".blue
					elsif square.surrounding_mines == 2
						output << "2".green
					elsif square.surrounding_mines == 3
						output << "3".red
					else
						output << square.surrounding_mines.to_s.blue
					end
				end
			end
			output << "\n"
		end
		output << "     ___________\n"
		output << "     12345678910\n"
		print output
	end

end