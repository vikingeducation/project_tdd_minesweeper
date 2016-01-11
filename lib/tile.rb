class Tile
	# mine?
	# is_revealed?
	# is_flagged?

	#set flagged status
	#set reveal status
	#create a mine
	#tile description

	attr_accessor :mine, :is_revealed, :is_flagged

	def initialize
		@mine = false
		@is_revealed = false
		@is_flagged = false
	end

	def revealed
		if @is_revealed
			puts "You've already selected that tile"
		else
			@is_revealed = true
		end
	end

	def flagged
		if @is_flagged
			@is_flagged = false
		else
			@is_flagged = true
		end
	end

	def make_mine
		@mine = true
	end
end