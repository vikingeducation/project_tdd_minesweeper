class Player
	# player chooses coordinates
	# choose kind of move
	#  	flag? or reveal?
	# make move(reveal or flag)
	#   flag a square
	#   reveal a square

	def initialize
	end

	def choose_coords
		puts "Please enter coordinates"
		choice = eval(gets.chomp)
	end
end