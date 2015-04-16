class Square
	attr_accessor :mine

	def initialize(coords)
		@coords = coords
		@mine = false
	end

	# Turns the square into a mine
	def make_mine
		@mine = true
	end
end