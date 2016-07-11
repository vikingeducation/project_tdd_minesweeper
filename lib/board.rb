require 'pry'


class Board


	def initialize( board = nil )

		@board = Array.new( 10 ) { Array.new( 10 ) }
		@flags = 9
		@mines = 9

	end

	def place_mines

		count = @mines

		until count < 0

			row = rand( 0..9 )
			col = rand( 0..9 )

			if @board[ row ][ col ] != 'M'
				@board[ row ][ col ] = 'M'
				count -= 1
			end

		end

		return @board

	end


	# check within proper coordinates
	def validate_move( move )



	end



end