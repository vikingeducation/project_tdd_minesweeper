require 'pry'

class Board
	attr_reader :game_board, :mines

	def initialize(size = 10, mines = 9)
		@mines = mines
		create_game_board(size)
		set_mines(mines)
		return nil
	end

	def create_game_board(size)
		@game_board = []
		for i in 0..((size**2)-1) do
			@game_board << Cell.new("#{i}") #changed from symbold to string just so I could test player can change the state of a square while avoiding mines
		end
	end

	def set_mines(no_of_mines)
		remaining_mines_to_set = no_of_mines
		while remaining_mines_to_set > 0
			square_to_plant_mine = @game_board.sample
			if square_to_plant_mine.mine == 0
				square_to_plant_mine.set_mine
				remaining_mines_to_set -= 1
			end
		end
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
		game_on?(square_to_change)
	end

	def game_on?(square_to_change)
		if @game_board[square_to_change].check_for_mine?
			puts "You lost!"
			return false
		end
	end

	def render_grid
		size_of_side = (@game_board.size)**(1.0/2)
		count = 0
		num_of_selected_squares = 0
		while count < @game_board.flatten.size
			count_in_row = 0
			print ("Row #{(count/size_of_side + 1).to_i}").ljust(10)		#http://www.unicode.org/charts/beta/nameslist/n_25A0.html
			while count_in_row < size_of_side do
				num_of_selected_squares += render_each_square(count + count_in_row)
				count_in_row += 1
			end
			puts ""
			count += size_of_side
		end
		return num_of_selected_squares  #returning only to make test pass
	end

	def render_each_square(position_in_grid)
		square_has_been_selected_test = 0
		if @game_board[position_in_grid].state == 1
			print "\u2B1C "
			square_has_been_selected_test += 1
		elsif @game_board[position_in_grid].state == 0
			print "\u2B1B "
		end
		return square_has_been_selected_test
	end
end

class Cell
	attr_reader :position_in_grid, :state, :flag, :mine
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

	def set_mine
		@mine = 1
	end

	def check_for_mine?
		@mine == 1 ? true : false
	end

	def check_surrounding_mines
	end

end