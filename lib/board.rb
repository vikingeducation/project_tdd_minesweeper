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

=begin
def detect
  return if @board[@row][@col] == '*'
  value = 0 # no need to be global anymore
  (@row - 1..@row + 1).each do |r|
    (@col - 1..@col + 1).each do |c|
      unless r < 0 || r >= @board.size || c < 0 || c >= @board.size
        value += 1 if @board[r][c] == "*"
      end
    end
  end
  @board[@row][@col] = value
end


def check
  (0..@board.size - 1).each do |r|
    (0..@board.size - 1).each do |c|
      @row, @col = r, c
      detect
    end
  end
  binding.pry
end

=end


	def populate_hints

		arr = @board
			# start with row 0 ( end when 10 [base case])
				# start at col 0
				# if != 'M'

		arr.each_with_index do | x , ri |

			x.each_with_index do | y , ci |



			end


		end




		return @board
		#find the first mine
		# go through the row above indexes 1,2,3 respectively
			# if nil && != 'M'
				# change to 1
			# elsif numeric
				# take value += 1
		# go through row it's on index before and after
			# if nil && != 'M'
				# change to 1
			# elsif numeric
				#take value += 1
		# start at each




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


	def check

		(0..@board.size - 1).each do |r|
	    (0..@board.size - 1).each do |c|
	      @row, @col = r, c
	      detect
	    end
	  end


	end


	def detect

	  return if @board[@row][@col] == '*'
	  value = 0 # no need to be global anymore
	  (@row - 1..@row + 1).each do |r|
	    (@col - 1..@col + 1).each do |c|
	      unless r < 0 || r >= @board.size || c < 0 || c >= @board.size
	        value += 1 if @board[r][c] == "*"
	      end
	    end
	  end
  	@board[@row][@col] = value


  end


end