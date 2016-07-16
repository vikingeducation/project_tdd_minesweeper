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


	def generate_minefield

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
				@mine_locations << [ row, col ]

				count -= 1

			end

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
			decrement_flag_count

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
			increment_flag_count

		end

	end


	def increment_flag_count

			@flags += 1

	end


	def decrement_flag_count

		@flags -= 1

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
	  elsif @board[ @row ][ @col ] == 0
	  	reveal
	  	auto_clear( @row, @col  )
	  else
			reveal
		end

	end


	def reveal

		@display_board[ @row ][ @col ]  = @board[ @row ][ @col ]

	end





	def auto_reveal_square( row, col )

		@display_board[ row ][ col ]  = @board[ row ][ col ]

	end



	def square_has_mine_count

		@board[ @row ][ @col ] >= 1 ? true : false

	end




	def check_for_mine

		return true if @board[ @row ][ @col ] == "*"

	end



  def auto_clear( row, col )


  	# function passes in the coordinates
  	# if the position is a mine it will return
  	# if the position is a number it will return
  	# if the position is already revealed, it will return
  			# revealed is a flag, number or 0

  	# may have to refactor reveal to have it happen here when a zero

  	# generate an array for every position around the sent coords
  	# TOP ROW
  	# [r-1][c-1], [r-1][c], [r-1][c+1],
  	# MIDDLE ROW
  	# [ r ][c-1], 				, [ r ][c + 1]
  	# BOTTOM ROW
  	# [r+1][c-1],[r+1][ c ],[r+1][c + 1]

  	# check every position in the array surrounding the coords
  	# if the position is a 0
  		# reveal
  		# call auto_clear( coords ) with those coordinates
  	# if the position is a mine_count
  		# reveal
  		# return
  	# if the position is a mine
  		# return


  	q = []

  	q << [ row, col ]

  	arr = []

	  	q.each do | n |

	  		w_row, e_row = n[0], n[0]
	  		w_col = n[1] - 1
	  		e_col = n[1] + 1

	  		# move left
	  		until @board[ w_row ][ w_col ] != 0 || w_col == 0

	  			arr << [ w_row , w_col  ]

	  			w_col -= 1

	  		end


	  		# move right
	  		until	@board[ e_row ][ e_col ] != 0 || e_col > @board.size - 1

	  			arr << [ e_row, e_col  ] unless e_col > @board.size - 1

	  			e_col += 1

	  		end


	  		arr.each do | c |

	  			row = c[0]
	  			col = c[1]


	  			auto_reveal_square( row, col )

	  			return if row - 1 < 0 || row + 1 > @board.size - 1

	  				if @board[ row - 1 ][ col ] == 0 && row <= 0

	  					q << [ row - 1 , col ]

	  				end

	  				if @board[ row + 1 ][ col ] == 0 && row < @board.size - 1

	  					q << [ row + 1, col ]

	  				end

	  		end #/.arr.each


	  	end #/.q.each

  end


end