require 'pry'


class Board

	attr_reader :flags, :display_board, :board

	def initialize( board = nil )

		@board = Array.new( 10 ) { Array.new( 10 ) {0}}
		@display_board = Array.new( 10 ) { Array.new( 10 ) {"-"} }

		@mine_locations = []

		@flags = 9
		@mines = 9

		@row = 0
		@col = 0


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

			 @row = coords[ 0 ]
			 @col = coords[ 1 ]

			 true
		else
			false
		end

	end




	def place_flag

		if @flags == 0

			puts "You are out of flags"
			return false

		elsif flag_already_there

			puts "Already a flag there"

		elsif square_already_revealed

			puts "That space is already revealed"

		elsif no_flag_at_location

			@display_board[ @row ][ @col ] = 'F'
			@flags -= 1

		end

	end


	def remove_flag

		if @flags == @mines

			puts "You have all your flags"
			false

		elsif square_already_revealed

			puts "That square is already revealed."

		elsif flag_already_there

			@display_board[ @row ][ @col ] = '-'
			@flags += 1

		end

	end



	def flag_already_there

		return true if @display_board[ @row ][ @col ] == 'F'

	end



	def no_flag_at_location

		return true if @display_board[ @row ][ @col ] == '-'

	end



	def square_already_revealed

		return true if @display_board[ @row ][ @col ] != '-' &&
								   @display_board[ @row ][ @col ] != 'F'
	end


#	def reveal( row , col )

#		@display_board[ row ][ col ]  = @board[ row ][ col ]

#	end



	def reveal_square

	  if square_already_revealed
	  	puts "Already revealed! Pick another."
	  	return
	  else
		@display_board[ @row ][ @col ]  = @board[ @row ][ @col ]
	  end


	end



	def square_has_mine_count

		@board[ @row ][ @col ] >= 1 ? true : false

	end




	def check_for_mine

		if @board[ @row ][ @col ] == "*"

			Game.lose

		end

	end




	def populate_hints

		(0..@board.size - 1).each do | row |

	    (0..@board.size - 1).each do | col |

	      @row, @col = row, col

	      add_mine_counts

	    end

	  end
	  return @board

	end


	def add_mine_counts

	  return if @board[ @row ][ @col ] == '*'

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