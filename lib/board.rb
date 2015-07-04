require 'pry'

class Board
	attr_reader :game_board, :mines

	def initialize(size = 10, mines = 9)
		@game_board = []
		for i in 0..((size**2)-1) do
			@game_board << Cell.new(:"#{i}")
		end
		@mines = mines
		return nil
	end

	def show_remaining_flags
		current_flags = 0
		@game_board.each do |square|
			if square.flag == 1
				current_flags += 1
			end
		end
		@mines - current_flags
	end

	def change_state_of_square(square_to_change)
		@game_board[square_to_change].state_change
	end

	def render
		size_of_side = (@game_board.size)**(1.0/2)
		count = 0
		selected_squares = 0
		while count < @game_board.flatten.size
			count_in_row = 0
			print ("Row #{(count/size_of_side + 1).to_i}").ljust(10)		#http://www.unicode.org/charts/beta/nameslist/n_25A0.html
			while count_in_row < size_of_side do
				#print "#{count + count_in_row}"
				if @game_board[count + count_in_row].state == 1
					print "\u2B1C "
					selected_squares += 1
				elsif @game_board[count + count_in_row].state == 0
					print "\u2B1B "
				end
				count_in_row += 1
			end
			puts ""
			count += size_of_side
		end
		return selected_squares  #returning only to make test pass
	end

end


class Cell
	attr_reader :position_in_grid, :state, :mine, :flag
	def initialize(position_in_grid)
		@position_in_grid = position_in_grid				# place of cell assigned by digit
		@state = 0    	     								# 0 or 1 for selected or not
		@mine = 0											# 0 or 1 for has mine or not
		@flag = 0
		@surrounding_mines = 0											# 0 or 1 for has flag or not
	end

	def state_change
		if @state == 0
			@state = 1
		else
			@state = 0
		end
	end

end