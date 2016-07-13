require 'pry'


class Board

	attr_reader :flags, :display_board, :board

	def initialize( board = nil )

		@board = Array.new( 10 ) { Array.new( 10 ) {'-'}}
		@display_board = Array.new( 10 ) { Array.new( 10 ){"O"} }

		@mine_locations = []

		@flags = 9
		@mines = 9

		@row = 0
		@col = 0

		place_mines

		populate_hints

	end

	def place_mines

		count = @mines

		until count < 0

			row = rand( 0..9 )
			col = rand( 0..9 )


			if @board[ row ][ col ] != '*'

				@board[ row ][ col ] = '*'
				@mine_locations << [row, col]

				count -= 1
			end

		end


		return @board

	end



	# check within proper coordinates
	def valid_coordinates?( coords )

		raise 'Must be string format 5, 6 ' if coords.is_a?( Numeric )

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


	def populate_hints

		(0..@board.size - 1).each do | row |

	    (0..@board.size - 1).each do | col |

	      @row, @col = row, col

	      check_position

	    end

	  end


	end


	def check_position

	  return if @board[@row][@col] == '*'

	  hint = 0

	  (@row - 1..@row + 1).each do | row |

	    (@col - 1..@col + 1).each do | col |

	      unless row < 0 || row >= @board.size || col < 0 || col >= @board.size

	        hint += 1 if @board[ row ][ col ] == "*"

	      end

	    end

	  end

  	@board[ @row ][ @col ] = hint


  end


end