require 'pry'


class Board

	attr_reader :flags, :display_board

	def initialize( board = nil )

		@board = Array.new( 10 ) { Array.new( 10 ) }
		@display_board = Array.new( 10 ) { Array.new( 10 ){"O"} }
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


	def populate_hints

		



	end

	# check within proper coordinates
	def valid_coordinates?( move )

		raise 'Must be string format 5, 6 ' if move.is_a?( Numeric )

		coords = move.split(",").map! { |x| x.strip.to_i }

		if ( 0...@board.size ).include?( coords[ 0 ] ) &&
			 ( 0...@board.size ).include?( coords[ 1 ] )
			 true
		else
			false
		end

	end


	def place_flag( coords )

		placement = coords.split(",").map! { |x| x.strip.to_i }

		if @flags == 0
			puts "You are out of flags"
			false
		else
			@board[ placement[0] ][ placement[ 1 ] ] = 'F'
		end

	end




end