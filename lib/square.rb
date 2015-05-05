class Square
	attr_accessor :mine, :flag, :displayed, :surrounding_mines
	attr_reader :coords, :adjacent_squares

	def initialize(coords, size)
		# I know there are a bunch of instance
		# variables here but I need most of them 
		# for this Square class.
		@coords = coords
		@size = size
		@mine = false
		@flag = false
		@displayed = false
		@adjacent_squares = get_adjacent_squares(@coords)
		@surrounding_mines = 0
	end

	# Turns the square into a mine
	def make_mine
		@mine = true
	end

	# Turn a flag on or off
	def switch_flag
		@flag = !@flag
	end

	# Show a square as displayed
	def display_square
		@displayed = true
	end

	# Get adjacent squares
	# NOTE: For this method we don't need to put this on the 
	# square class- should probably be part of the board.

	def get_adjacent_squares(coords)
		x, y, adj_squares = coords[0], coords[1], []
		# Loop through the columns
		(x-1).upto(x+1) do |column|
			# Loop through the rows
			(y-1).upto(y+1) do |row|
				(adj_squares << [column, row]) if (row >= 1 && row <= @size) && (column >= 1 && column <= @size) && !(column == x && row == y)
			end
		end
		adj_squares
	end
end