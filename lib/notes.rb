
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

# base case is there is a number
# at a coordinate, it checks for 0 all around
#

######

=begin
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

=end

