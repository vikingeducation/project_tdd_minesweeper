class Square
	attr_accessor :mine, :flag, :displayed, 
	attr_reader :adjacent_squares, :mine_adjacent, :surrounding_mines

	def initialize(coords)
		@coords = coords
		@mine = false
		@flag = false
		@displayed = false
		@adjecent_squares = get_adjacent_squares(@coords)
		@mine_adjacent = mine_adjacent?
		@surrounding_mines = get
	end

	# Turns the square into a mine
	def make_mine
		@mine = true
	end


end