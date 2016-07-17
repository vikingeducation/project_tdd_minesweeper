class Board

	attr_reader :flags, :display_board, :board

	def initialize( board = nil )

		@board = Array.new( 10 ) { Array.new( 10 ) {0}}
		@display_board = Array.new( 10 ) { Array.new( 10 ) {"-"} }
		@victory_board = Array.new( 10 ) { Array.new( 10 ) {0}}


		@flags = 9
		@mines = 9

		@row = 0
		@col = 0


	end


	def generate_boards

		place_mines
		populate_hints

		generate_victory_board

	end




	def generate_victory_board

		@board.each_with_index do | row, r_index |

			row.each_with_index do | col, c_index |

				if @board[ r_index ][ c_index ] == '*'

					@victory_board[ r_index ][ c_index ] = 'F'

				else

					@victory_board[ r_index ][ c_index ] = @board[ r_index ][ c_index ]

				end

			end

		end

	end





	def place_mines

		count = @mines

		until count <= 0

			row = rand( 0..9 )
			col = rand( 0..9 )


			if @board[ row ][ col ] != '*'

				@board[ row ][ col ] = '*'
				@victory_board[ row ][ col ] = 'F'
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




	def reveal_square

	  if square_already_revealed
	  	puts "Already revealed! Pick another."
	  	return
	  else
	  	auto_clear( @row, @col  )
		end

	end




	def square_already_revealed

		return true if @display_board[ @row ][ @col ] != '-' &&
								   @display_board[ @row ][ @col ] != 'F'
	end




	def reveal

		@display_board[ @row ][ @col ]  = @board[ @row ][ @col ]

	end





	def square_has_mine_count

		@board[ @row ][ @col ] >= 1 ? true : false

	end




	def check_for_mine

		return true if @board[ @row ][ @col ] == "*"

	end




	def check_victory

		@display_board == @victory_board ? true : false

	end



	def out_of_bounds

		return true if @row > @board.size - 1 || @row < 0 || @col > @board.size - 1 || @col < 0

	end



  def auto_clear( row, col )

  	@row = row
  	@col = col

	  	return if out_of_bounds

	  	return if check_for_mine

	  	return if square_already_revealed

	  	# only reveal the square if has a mine count
	  	if square_has_mine_count
	  		reveal
	  		return
	  	else # this is when square has 0
	  		reveal
	  	end

  	adjacent_cells_coords = [
  													# TOP ROW
  													[ @row - 1, @col - 1 ],
  													[ @row - 1, @col     ],
  													[ @row - 1, @col + 1 ],
  													# MID ROW
  													[ @row    , @col - 1 ],
  													[ @row    , @col + 1 ],
  													# BOTTOM ROW
  													[ @row + 1, @col - 1 ],
  													[ @row + 1, @col     ],
  													[ @row + 1, @col + 1 ]
  													]

  		adjacent_cells_coords.each do | x |

  			@row, @col = x[ 0 ], x[ 1 ]

			  auto_clear( @row, @col )

			end

  end


end