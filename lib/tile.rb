class Tile

	attr_accessor :is_mine, :is_revealed, :is_flagged

	def initialize(options={})
		@is_mine = options[:is_mine] || false
		@is_revealed = options[:is_revealed] || false
		@is_flagged = options[:is_flagged] || false
	end

	def reveal
		@is_revealed = true
	end

	def flag
		@is_flagged = !@is_flagged
	end

	def make_mine
		@is_mine = true
	end

	def mine?
		@is_mine
	end

	def revealed?
		@is_revealed
	end

	def flagged?
		@is_flagged
	end
end