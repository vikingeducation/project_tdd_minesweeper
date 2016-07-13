# RENDER INITIAL GAME BOARD
	# 10 x 10 square
	# 9 mines
	# show remaining flags
# CLEARING SQAURES
	# should be able to change state of a square
		# ones state 'cleared'
		# appeared cleared in the render
# LOSS
	# game over if mine exposed
# DISPLAY MINE COUNTS
	# Clearing a square should expose that square's nearby mine count
# PLACING FLAGS
	# The board should display between inputs
  # Player shouldn't be able to place flags if no more flags
  # Player should only be able to place flags on uncleared spaces
  # Player remaining flag counter should update properly
  # Flagged squares should appear flagged in the render
# AUTO CLEARING SQUARES
	# logically obvious sqaure removed at render if no mines
# VICTORY
	# If all squares cleared except mines == victory!
# OPTIONAL
	# TIME COUNTER
	# VARIABLE MINE COUNTS
	# SAVING AND LOADING GAMES

# [
# 	[ O, O, O, O, O, O, O, O, O, O ]
# 	[ O, O, O, O, O, O, O, O, O, O ]
# 	[ O, O, O, O, O, O, O, O, O, O ]
# 	[ O, O, O, O, O, O, O, O, O, O ]
# 	[ O, O, O, O, O, O, O, O, O, O ]
# 	[ O, O, O, O, O, O, O, O, O, O ]
# 	[ O, O, O, O, O, O, O, O, O, O ]
# 	[ O, O, O, O, O, O, O, O, O, O ]
# 	[ O, O, O, O, O, O, O, O, O, O ]
# 	[ O, O, O, O, O, O, O, O, O, O ]
# ]

# if the index is + 1 -1 or same and row is +1, -1 or same, then we have a mine next to a number
# all the values should be populated when game starts
# the grid should 'reveal' when selected

# mines populate first
# then numbering system

# CLASSES
	# RENDER
		# SHOW BOARD
			# RENDER FLAGS
		# SHOW FLAG COUNT
		# SHOW MESSAGES

	# PLAYER
		# @FLAGS
		# SELECT SQUARE
		# PLACE FLAG
		# QUIT GAME

	# MINESWEEPER GAME
		# VICTORY?
			# ALL MINES MARKED
			# ALL SQUARES REVEALED/CLEARED
		# LOSS
			# MINE REVEALED

	# BOARD
		# @MINES
		# VALIDATE MOVE
			# UNCLEARED SQAURE
			# VALID COORDINATE
		# CLEAR SQUARE
			# CHECKS VICTORY/LOSS
		# AUTO CLEAR
			# REVEAL SQUARES AROUND AREA THAT HAVE NO MINES
		# knows how many flags
		# knows mine placement
		# know board
=begin
arr = @board

		arr.each_with_index do | row, ridx|


			row.each_with_index do | col, cidx |

				if arr[ ridx ][ cidx ] == 'M'

					 #top left
					 if arr[ ridx - 1 ][ cidx - 1 ].is_a?( Fixnum )

					 		arr[ ridx - 1 ][ cidx - 1 ] += 1

					 else

					 		arr[ ridx - 1 ][ cidx - 1 ] = 1 unless
					 		arr[ ridx - 1 ][ cidx - 1 ] == nil ||
					 		arr[ ridx - 1 ][ cidx - 1 ] == 'M'

				   end


				   #top
					 if arr[ ridx - 1 ][ cidx ].is_a?( Fixnum )

					 		arr[ ridx - 1 ][ cidx ] += 1

					 else

					 		arr[ ridx - 1 ][ cidx ] = 1 unless
					 		arr[ ridx - 1 ][ cidx ] == nil ||
					 		arr[ ridx - 1 ][ cidx ] == 'M'

				   end

				   #top right
					 if arr[ ridx - 1 ][ cidx + 1].is_a?( Fixnum )

					 		arr[ ridx - 1 ][ cidx + 1] += 1

					 else

					 		arr[ ridx - 1 ][ cidx + 1 ] = 1 unless
					 		arr[ ridx - 1 ][ cidx + 1 ] == nil ||
					 		arr[ ridx - 1 ][ cidx + 1 ] == 'M'

				   end

				   #left
					 if arr[ ridx ][ cidx - 1 ].is_a?( Fixnum )

					 		arr[ ridx ][ cidx - 1 ] += 1

					 else

					 		arr[ ridx ][ cidx - 1 ] = 1 unless
					 		arr[ ridx ][ cidx - 1 ] == nil ||
					 		arr[ ridx ][ cidx - 1 ] == 'M'

				   end

				   # right
					 if arr[ ridx ][ cidx + 1 ].is_a?( Fixnum )

					 		arr[ ridx ][ cidx + 1 ] += 1

					 else

					 		arr[ ridx ][ cidx + 1 ] = 1 unless
					 		arr[ ridx ][ cidx + 1 ] == nil ||
					 		arr[ ridx ][ cidx + 1 ] == 'M'

				   end



				   # bottom left
					 if arr[ ridx + 1 ][ cidx - 1 ].is_a?( Fixnum ) && arr[ ridx ][ cidx - 1 ] != nil

					 		arr[ ridx + 1 ][ cidx - 1 ] += 1

					 else

					 		arr[ ridx + 1 ][ cidx - 1 ] = 1 unless
					 		arr[ ridx + 1 ][ cidx - 1 ] == nil ||
					 		arr[ ridx + 1 ][ cidx - 1 ] == 'M'

				   end


				   # bottom
					 if arr[ ridx + 1 ][ cidx ].is_a?( Fixnum )

					 		arr[ ridx + 1 ][ cidx ] += 1

					 else

					 		arr[ ridx + 1 ][ cidx ] = 1 unless
					 		arr[ ridx + 1 ][ cidx ] == nil ||
					 		arr[ ridx + 1 ][ cidx ] == 'M'

				   end


				   #  bottom right
					 if arr[ ridx + 1 ][ cidx + 1 ].is_a?( Fixnum )

					 		arr[ ridx + 1 ][ cidx + 1 ] += 1

					 else

					 		arr[ ridx + 1 ][ cidx + 1 ] = 1 unless
					 		arr[ ridx + 1 ][ cidx + 1 ] == nil ||
					 		arr[ ridx + 1 ][ cidx + 1 ] == 'M'

				   end


				end

			end


		end

=end